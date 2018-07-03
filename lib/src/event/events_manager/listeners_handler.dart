part of events_manager;

class _ListenersHandler {
  _ListenersHandler() {
    _dayToListenersMap = new Map();
  }

  Map<Date, Set<EventsChangedListener>> _dayToListenersMap;

  void addListener({
    @required Date day,
    @required EventsChangedListener listener,
  }) {
    _initialiseDayIfNeeded(day);
    _dayToListenersMap[day].add(listener);
  }

  void removeListener({
    @required Date day,
    @required EventsChangedListener listener,
  }) {
    _getListenersOf(day: day).remove(listener);
    _cleanIfNoListeners(day);
  }

  void invokeListenersOf({
    @required Date day,
  }) {
    for (EventsChangedListener listener in _getListenersOf(day: day)) {
      _invokeListener(listener);
    }
  }

  void _initialiseDayIfNeeded(Date day) {
    if (!_hasDayBeenInitialised(day)) {
      _dayToListenersMap[day] = new Set();
    }
  }

  bool _hasDayBeenInitialised(Date day) {
    return _dayToListenersMap.containsKey(day);
  }

  void _invokeListener(EventsChangedListener listener) {
    try {
      listener.onEventsChanged();
    } catch (e) {
      print("Error invoking EventsChangedListener: $e");
    }
  }

  Set<EventsChangedListener> _getListenersOf({
    @required Date day,
  }) {
    if (_hasDayBeenInitialised(day)) {
      return _dayToListenersMap[day];
    } else {
      return new Set();
    }
  }

  void _cleanIfNoListeners(Date day) {
    if (_dayToListenersMap[day].isEmpty) {
      _dayToListenersMap.remove(day);
    }
  }
}

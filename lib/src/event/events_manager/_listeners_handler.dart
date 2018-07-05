import 'package:meta/meta.dart';

import 'package:calendar_views/src/internal_date_items/all.dart';

import 'events_changed_listener.dart';

class ListenersHandler {
  ListenersHandler() {
    _dateToListenersMap = new Map();
  }

  Map<Date, Set<EventsChangedListener>> _dateToListenersMap;

  void addListener(Date date, EventsChangedListener listener) {
    _initialiseDateIfNeeded(date);
    _dateToListenersMap[date].add(listener);
  }

  void removeListener(Date date, EventsChangedListener listener) {
    _getListenersOf(date).remove(listener);
    _cleanIfNoListeners(date);
  }

  void invokeListenersOf(Date date) {
    for (EventsChangedListener listener in _getListenersOf(date)) {
      _invokeListener(listener);
    }
  }

  void _initialiseDateIfNeeded(Date date) {
    if (!_hasDateBeenInitialised(date)) {
      _dateToListenersMap[date] = new Set();
    }
  }

  bool _hasDateBeenInitialised(Date day) {
    return _dateToListenersMap.containsKey(day);
  }

  void _invokeListener(EventsChangedListener listener) {
    try {
      listener.onEventsChanged();
    } catch (e) {
      print("Error invoking EventsChangedListener: $e");
    }
  }

  Set<EventsChangedListener> _getListenersOf(Date date) {
    if (_hasDateBeenInitialised(date)) {
      return _dateToListenersMap[date];
    } else {
      return new Set();
    }
  }

  void _cleanIfNoListeners(Date date) {
    if (_dateToListenersMap[date].isEmpty) {
      _dateToListenersMap.remove(date);
    }
  }
}

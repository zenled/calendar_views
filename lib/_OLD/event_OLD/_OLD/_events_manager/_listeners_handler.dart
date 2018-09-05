import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/event/calendar_events/events_changed_listener.dart';

/// Class that handles [EventsChangedListener]s.
@immutable
class ListenersHandler {
  ListenersHandler() : _dateToListenersMap = new Map();

  final Map<Date, Set<EventsChangedListener>> _dateToListenersMap;

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

  bool _hasDateBeenInitialised(Date date) {
    return _dateToListenersMap.containsKey(date);
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

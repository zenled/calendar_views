import 'dart:async';

import 'package:meta/meta.dart';

import '../positionable_event.dart';

import 'package:calendar_views/src/internal_date_items/all.dart';

/// Function that returns a Future with a set of events that happen on specific [date].
typedef Future<Set<PositionableEvent>> EventsFetcher(DateTime date);

/// Callback that occurs when a set of events that happen on some day has been changed.
typedef void OnEventsChangedCallback();

typedef void EventsOfDateChangedListenerCallback(
    EventsOfDateChangedListener listener);

/// Class for listening for changes of events of [date].
class EventsOfDateChangedListener {
  EventsOfDateChangedListener({
    @required this.date,
    @required this.onEventsChanged,
  })  : assert(date != null),
        assert(onEventsChanged != null);

  final DateTime date;

  final OnEventsChangedCallback onEventsChanged;
}

/// Class that retrieves, stores and refreshes events and notifies listeners when changes happen.
class EventsMaster {
  EventsMaster({
    @required EventsFetcher eventsFetcher,
  }) : assert(eventsFetcher != null) {
    _eventsFetcher = eventsFetcher;

    _eventsStorage = new _EventsStorage();
    _listenersHandler = new _ListenersHandler();
  }

  EventsFetcher _eventsFetcher;

  _EventsStorage _eventsStorage;

  _ListenersHandler _listenersHandler;

  set eventsFetcher(EventsFetcher value) => _eventsFetcher = _eventsFetcher;

  /// Returns a set of [PositionableEvent]s that happen on specific [date].
  Set<PositionableEvent> getEventsOfDate(DateTime date) {
    Date day = Date.fromDateTime(date);

    if (!_eventsStorage.haveEventOfDayBeenSet(day)) {
      _handleRefreshOfEventsOfDay(day);
    }

    return _eventsStorage.getEventsOfDay(day);
  }

  /// Refreshes events for a specific [date].
  void refreshEventsOfDate(DateTime date) {
    Date day = new Date.fromDateTime(date);

    _handleRefreshOfEventsOfDay(day);
  }

  /// Refreshes events for all dates that have previously been fetched.
  void refreshEventsOfAllDates() {
    for (Date day in _eventsStorage.daysWhoseEventsHaveBeenSet()) {
      _handleRefreshOfEventsOfDay(day);
    }
  }

  void attachListener(EventsOfDateChangedListener listener) {
    assert(listener != null);

    Date day = new Date.fromDateTime(listener.date);

    _listenersHandler.addListener(
      day: day,
      listener: listener,
    );
  }

  void detachListener(EventsOfDateChangedListener listener) {
    assert(listener != null);

    Date day = new Date.fromDateTime(listener.date);

    _listenersHandler.removeListener(
      day: day,
      listener: listener,
    );
  }

  Future _handleRefreshOfEventsOfDay(Date day) async {
    Set<PositionableEvent> eventsOnDay = await _fetchEvents(day);
    _eventsStorage.setEventsOfDay(
      day: day,
      events: eventsOnDay,
    );
    _listenersHandler.invokeListenersOfDay(day);
  }

  Future<Set<PositionableEvent>> _fetchEvents(Date day) {
    return _eventsFetcher(day.toDateTime());
  }
}

class _EventsStorage {
  _EventsStorage() {
    _dayToEventsMap = new Map();
  }

  Map<Date, Set<PositionableEvent>> _dayToEventsMap;

  bool haveEventOfDayBeenSet(Date day) {
    return _dayToEventsMap.containsKey(day);
  }

  Set<Date> daysWhoseEventsHaveBeenSet() {
    return _dayToEventsMap.keys.toSet();
  }

  void setEventsOfDay({
    @required Date day,
    @required Set<PositionableEvent> events,
  }) {
    _dayToEventsMap[day] = events;
  }

  Set<PositionableEvent> getEventsOfDay(Date day) {
    if (_dayToEventsMap.containsKey(day)) {
      return _dayToEventsMap[day];
    }
    return new Set();
  }
}

class _ListenersHandler {
  _ListenersHandler() {
    _dayToChangeListenersMap = new Map();
  }

  Map<Date, Set<EventsOfDateChangedListener>> _dayToChangeListenersMap;

  void addListener({
    @required Date day,
    @required EventsOfDateChangedListener listener,
  }) {
    assert(day != null);
    assert(listener != null);

    if (!_hasDayBeenInitialised(day)) {
      _initialiseDay(day);
    }

    _dayToChangeListenersMap[day].add(listener);
  }

  void removeListener({
    @required Date day,
    @required EventsOfDateChangedListener listener,
  }) {
    assert(day != null);
    assert(listener != null);

    if (_dayToChangeListenersMap.containsKey(day)) {
      _dayToChangeListenersMap[day].remove(listener);

      if (_dayToChangeListenersMap[day].isEmpty) {
        _dayToChangeListenersMap.remove(day);
      }
    }
  }

  void invokeListenersOfDay(Date day) {
    if (_dayToChangeListenersMap.containsKey(day)) {
      for (EventsOfDateChangedListener listener
          in _dayToChangeListenersMap[day]) {
        listener.onEventsChanged();
      }
    }
  }

  bool _hasDayBeenInitialised(Date day) {
    return _dayToChangeListenersMap.containsKey(day);
  }

  void _initialiseDay(Date day) {
    _dayToChangeListenersMap[day] = new Set();
  }
}

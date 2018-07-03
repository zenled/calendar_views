library events_manager;

import 'dart:async';

import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/events/positionable_event.dart';
import 'package:calendar_views/src/internal_date_items/all.dart';

part 'events_changed_listener.dart';

part 'events_storage.dart';

part 'listeners_handler.dart';

/// Function that returns a Future with a set of events that happen on specific [date].
typedef Future<Set<PositionableEvent>> EventsFetcher(DateTime date);

/// Class that retrieves, stores and refreshes events and notifies listeners when changes happen.
class EventsManager {
  EventsManager({
    @required EventsFetcher eventsFetcher,
  }) : assert(eventsFetcher != null) {
    _eventsFetcher = eventsFetcher;

    _eventsStorage = new _EventsStorage();
    _listenersHandler = new _ListenersHandler();
    _daysForWhichCurrentlyFetchingEvents = new Set();
  }

  EventsFetcher _eventsFetcher;

  _EventsStorage _eventsStorage;

  _ListenersHandler _listenersHandler;

  Set<Date> _daysForWhichCurrentlyFetchingEvents;

  void updateEventsFetcher(EventsFetcher fetcher) {
    _eventsFetcher = fetcher;
  }

  /// Returns a set of [PositionableEvent]s that happen on specific [date].
  Set<PositionableEvent> getEventsOf({
    @required DateTime date,
  }) {
    assert(date != null);

    Date day = Date.fromDateTime(date);

    if (!_eventsStorage.haveEventOfDayBeenStored(day)) {
      _handleRefreshOfEventsOf(day: day);
    }

    return _eventsStorage.retrieveEventsOf(day: day);
  }

  /// Refreshes events of a specific [date].
  void refreshEventsOf({
    @required DateTime date,
  }) {
    assert(date != null);

    Date day = new Date.fromDateTime(date);

    _handleRefreshOfEventsOf(day: day);
  }

  /// Refreshes events for all dates that have previously been fetched.
  void refreshEventsOfAllDates() {
    for (Date day in _eventsStorage.daysWhoseEventsHaveBeenStored()) {
      _handleRefreshOfEventsOf(day: day);
    }
  }

  void attachEventsChangedListener(EventsChangedListener listener) {
    Date day = new Date.fromDateTime(listener.date);

    _listenersHandler.addListener(day: day, listener: listener);
  }

  void detachEventsChangedListener(EventsChangedListener listener) {
    Date day = new Date.fromDateTime(listener.date);

    _listenersHandler.removeListener(day: day, listener: listener);
  }

  void _handleRefreshOfEventsOf({
    @required Date day,
  }) {
    if (_daysForWhichCurrentlyFetchingEvents.contains(day)) {
      return;
    } else {
      _daysForWhichCurrentlyFetchingEvents.add(day);
      _refreshEventsOf(day: day);
    }
  }

  Future<Set<PositionableEvent>> _fetchEvents(Date day) {
    return _eventsFetcher(day.toDateTime());
  }

  Future _refreshEventsOf({
    @required Date day,
  }) async {
    Set<PositionableEvent> eventsOfDay = await _fetchEvents(day);

    _daysForWhichCurrentlyFetchingEvents.remove(day);

    _eventsStorage.storeEvents(day: day, events: eventsOfDay);
    _listenersHandler.invokeListenersOf(day: day);
  }
}

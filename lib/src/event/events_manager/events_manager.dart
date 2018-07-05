import 'dart:async';

import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/events/positionable_event.dart';
import 'package:calendar_views/src/internal_date_items/all.dart';

import '_events_fetcher.dart';
import '_events_storage.dart';
import '_listeners_handler.dart';

import 'events_changed_listener.dart';
import 'events_of_day_retriever.dart';

/// Class that retrieves, stores and refreshes events and notifies listeners when changes happen.
class EventsManager {
  EventsManager({
    @required EventsOfDayRetriever eventsRetriever,
  }) {
    _fetcher = new EventsFetcher(
      eventsRetriever: eventsRetriever,
      onFetchCompleted: _onFetchCompleted,
    );
    _storage = new EventsStorage();
    _listenersHandler = new ListenersHandler();
  }

  EventsFetcher _fetcher;
  EventsStorage _storage;
  ListenersHandler _listenersHandler;

  void changeEventsRetriever(EventsOfDayRetriever retriever) {
    _fetcher.changeRetriever(retriever);
  }

  Set<PositionableEvent> getEventsOf(DateTime day) {
    Date date = Date.fromDateTime(day);

    if (!_storage.haveEventOfDayBeenStored(date)) {
      _fetcher.fetchEventsOf(date);
    }

    return _storage.retrieveOf(date);
  }

  void refreshEventsOf(DateTime day) {
    Date date = new Date.fromDateTime(day);

    _fetcher.fetchEventsOf(date);
  }

  /// Refreshes events for all dates that have previously been fetched.
  void refreshAllEvents() {
    for (Date date in _storage.daysWhoseEventsHaveBeenStored()) {
      _fetcher.fetchEventsOf(date);
    }
  }

  void attachEventsChangedListener(EventsChangedListener listener) {
    Date date = new Date.fromDateTime(listener.day);

    _listenersHandler.addListener(date, listener);
  }

  void detachEventsChangedListener(EventsChangedListener listener) {
    Date date = new Date.fromDateTime(listener.day);

    _listenersHandler.removeListener(date, listener);
  }

  void _onFetchCompleted(Date date, Set<PositionableEvent> events) {
    _storage.store(date, events);
    _listenersHandler.invokeListenersOf(date);
  }
}

import 'dart:async';

import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/event.dart';
import 'package:calendar_views/event_management.dart';

import '_listeners_handling/all.dart';
import '_storage/all.dart';

class EventManager {
  EventManager({
    @required this.eventFetchers,
  })  : assert(eventFetchers != null),
        _storage = new EventStorage(),
        _listenersHandler = new ListenersHandler();

  List<EventFetcher> eventFetchers;

  final EventStorage _storage;
  final ListenersHandler _listenersHandler;

  Set<CalendarViewsEvent> getEventsOfDay(DateTime day) {
    Date date = new Date.fromDateTime(day);

    if (!_storage.haveEventsOfDateBeenStored(date)) {
      _startRetrievalOfEventsOnDate(date);
    }

    return _storage.retrieveOf(date);
  }

  void refreshEventsOnDay(DateTime day) {
    Date date = new Date.fromDateTime(day);

    _startRetrievalOfEventsOnDate(date);
  }

  void refreshAllDays() {
    for (Date date in _storage.daysWhichEventsHaveBeenStored()) {
      _startRetrievalOfEventsOnDate(date);
    }
  }

  void attach(EventsChangedListener listener) {
    Date date = new Date.fromDateTime(listener.day);

    _listenersHandler.addListener(date, listener);
  }

  void detach(EventsChangedListener listener) {
    Date date = new Date.fromDateTime(listener.day);

    _listenersHandler.removeListener(date, listener);
  }

  void _startRetrievalOfEventsOnDate(Date date) {
    Future
        .wait(
      eventFetchers.map(
        (eventsFetcher) => eventsFetcher.fetchEventsOnDay(date.toDateTime()),
      ),
    )
        .then(
      (List<Set<CalendarViewsEvent>> fetchersEvents) {
        Set<CalendarViewsEvent> events = new Set();
        for (Set<CalendarViewsEvent> events in fetchersEvents) {
          events.addAll(events);
        }

        _onRetrievalOfEventsOnDayCompleted(date, events);
      },
    );
  }

  void _onRetrievalOfEventsOnDayCompleted(
    Date date,
    Set<CalendarViewsEvent> events,
  ) {
    _storage.store(date, events);
    _listenersHandler.invokeListenersOf(date);
  }
}

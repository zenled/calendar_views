import 'dart:async';

import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_items/all.dart';
import 'package:calendar_views/src/event/calendar_events/events_generator.dart';
import 'package:calendar_views/src/event/events/positionable_event.dart';

/// Signature for a function that handles fetched [events] of [date].
typedef void OnEventsFetchCompleted(
  Date date,
  Set<PositionableEvent> events,
);

/// Class that handles fetching of events.
class EventsFetcher {
  EventsFetcher({
    @required EventsGenerator eventsRetriever,
    @required this.onFetchCompleted,
  })  : _daysForWhichCurrentlyFetching = new Set(),
        assert(eventsRetriever != null),
        assert(onFetchCompleted != null);

  /// Callback that fires when fetch for events of some day has completed.
  final OnEventsFetchCompleted onFetchCompleted;

  /// Object that that retrieves the events.
  EventsGenerator _eventsRetriever;

  /// Set of days of which events are currently being fetched.
  final Set<Date> _daysForWhichCurrentlyFetching;

  /// Tells the fetcher to use a different [EventsGenerator].
  void changeRetriever(EventsGenerator newRetriever) {
    _eventsRetriever = newRetriever;
  }

  /// Prompts this fetcher to fetch events of [date].
  ///
  /// If events of [date] are already in the process of fetching it does nothing.
  void fetchEventsOf(Date date) {
    if (!isFetchingEventsOf(date)) {
      _startFetching(date);
    }
  }

  /// Returns true if this fetcher is currently fetching events of [date].
  bool isFetchingEventsOf(Date date) {
    return _daysForWhichCurrentlyFetching.contains(date);
  }

  void _startFetching(Date date) {
    _markFetching(date);
    _fetch(date);
  }

  Future _fetch(Date date) async {
    Set<PositionableEvent> fetchedEvents;

    fetchedEvents = await _eventsRetriever.generateEventsOf(
      date.toDateTime(),
    );

    _onFetchCompleted(date, fetchedEvents);
  }

  void _onFetchCompleted(Date date, Set<PositionableEvent> events) {
    _markNotFetching(date);
    onFetchCompleted(date, events);
  }

  void _markFetching(Date date) {
    _daysForWhichCurrentlyFetching.add(date);
  }

  void _markNotFetching(Date date) {
    _daysForWhichCurrentlyFetching.remove(date);
  }
}

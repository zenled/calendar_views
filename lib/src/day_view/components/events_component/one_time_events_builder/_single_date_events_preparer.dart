part of one_time_events_builder;

/// Utility that prepares events of some [date].
class _SingleDateEventsPreparer {
  _SingleDateEventsPreparer({
    @required this.context,
    @required this.date,
    @required this.eventsFilter,
  })  : assert(context != null),
        assert(date != null);

  final BuildContext context;

  final DateTime date;

  final EventsFilter eventsFilter;

  Set<PositionableEvent> getAndPrepareEvents() {
    Set<PositionableEvent> events;

    events = _retrieveEvents();
    events = _removeAllDayEvents(events);
    events = _filterEvents(events);
    events = _extractFullyVisibleEvents(context, events);

    return events;
  }

  Set<PositionableEvent> _retrieveEvents() {
    return EventsProvider.of(context).getEventsOf(date: date);
  }

  Set<PositionableEvent> _removeAllDayEvents(
    Iterable<PositionableEvent> events,
  ) {
    return events.where((event) => !event.isAllDay).toSet();
  }

  Set<PositionableEvent> _filterEvents(Iterable<PositionableEvent> events) {
    if (eventsFilter != null) {
      return events
          .where((event) => eventsFilter.shouldEventBeShown(event))
          .toSet();
    } else {
      return events.toSet();
    }
  }

  Set<PositionableEvent> _extractFullyVisibleEvents(
    BuildContext context,
    Iterable<PositionableEvent> events,
  ) {
    int minimumMinuteOfDay = DayViewRestrictions.of(context).minimumMinuteOfDay;
    int maximumMinuteOfDay = DayViewRestrictions.of(context).maximumMinuteOfDay;

    return events
        .where(
          (event) =>
              event.beginMinuteOfDay >= minimumMinuteOfDay &&
              (event.beginMinuteOfDay + event.duration) <= maximumMinuteOfDay,
        )
        .toSet();
  }
}

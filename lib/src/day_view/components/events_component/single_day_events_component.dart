part of events_component;

/// [DayViewComponent] that builds events of a single day.
class SingleDayEventsComponent extends DayViewComponent {
  /// Creates a [DayViewComponent] that builds events of a single day.
  const SingleDayEventsComponent({
    this.eventsFilter,
    this.eventsArranger = const ExtendedColumnsEventsArranger(),
    @required this.itemBuilder,
  })  : assert(eventsArranger != null),
        assert(itemBuilder != null);

  /// Item that tells this component if certain event should be shown.
  final EventsFilter eventsFilter;

  /// Object that arranges the events.
  final EventsArranger eventsArranger;

  /// Function that builds an event.
  final EventBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    Set<PositionableEvent> events = _prepareEvents(context);

    List<ArrangedEvent> arrangedEvents = eventsArranger.arrangeEvents(
      events: events,
      constraints: _makeArrangerConstraints(context),
    );

    // builds events
    for (ArrangedEvent arrangedEvent in arrangedEvents) {
      items.add(
        itemBuilder(
          context: context,
          position: arrangedEvent.position,
          size: arrangedEvent.size,
          event: arrangedEvent.event,
        ),
      );
    }

    return items;
  }

  Set<PositionableEvent> _prepareEvents(BuildContext context) {
    Set<PositionableEvent> events = _retrieveEvents(context);
    events = _removeAllDayEvents(events);
    events = _filterEvents(events);
    events = _extractVisibleEvents(context, events);

    return events;
  }

  Set<PositionableEvent> _retrieveEvents(BuildContext context) {
    DateTime date = DayViewDate.of(context).date;

    return EventsProvider.of(context).getEventsOf(date: date);
  }

  Set<PositionableEvent> _filterEvents(Iterable<PositionableEvent> events) {
    if (eventsFilter != null) {
      return events
          .where(
            (event) => eventsFilter.shouldEventBeShown(event),
          )
          .toSet();
    } else {
      return events.toSet();
    }
  }

  Set<PositionableEvent> _removeAllDayEvents(
    Iterable<PositionableEvent> events,
  ) {
    return events
        .where(
          (event) => !event.isAllDay,
        )
        .toSet();
  }

  Set<PositionableEvent> _extractVisibleEvents(
      BuildContext context, Iterable<PositionableEvent> events) {
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

  ArrangerConstraints _makeArrangerConstraints(BuildContext context) {
    DayViewPositioner positioner =
        DayViewPositionerGenerator.of(context).createPositioner(context);

    return new ArrangerConstraints(
      areaLeft: positioner.eventsAreaLeft,
      areaWidth: positioner.eventAreaWidth,
      positionTop: positioner.minuteOfDayFromTop,
      height: positioner.heightOfMinutes,
    );
  }
}

part of events_component;

/// [DayViewComponent] that builds events of a single day.
class SingleDayEventsComponent extends DayViewComponent {
  /// Creates a [DayViewComponent] that builds events of a single day.
  const SingleDayEventsComponent({
    this.eventsFilter,
    this.eventsArranger = const ExtendedColumnsEventsArranger(),
    @required this.eventsBuilder,
  })  : assert(eventsArranger != null),
        assert(eventsBuilder != null);

  /// Item that tells this component if certain event should be shown.
  final EventsFilter eventsFilter;

  /// Object that arranges the events.
  final EventsArranger eventsArranger;

  /// Function that builds an event.
  final EventBuilder eventsBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    Set<PositionableEvent> events = _getEvents(context);
    return _buildItemsFromEvents(context, events);
  }

  Set<PositionableEvent> _getEvents(BuildContext context) {
    return new _EventsPreparer(
      context: context,
      eventsFilter: eventsFilter,
    ).getAndPrepareEvents();
  }

  List<Positioned> _buildItemsFromEvents(
    BuildContext context,
    Set<PositionableEvent> events,
  ) {
    DayViewPositioner positioner =
        DayViewPositionerGenerator.of(context).createPositioner(context);

    return new _ItemsBuilder(
      context: context,
      arranger: eventsArranger,
      positioner: positioner,
      itemBuilder: eventsBuilder,
      events: events,
    ).makeItems();
  }
}

class _EventsPreparer {
  _EventsPreparer({
    @required this.context,
    @required this.eventsFilter,
  }) : assert(context != null);

  final BuildContext context;

  final EventsFilter eventsFilter;

  Set<PositionableEvent> getAndPrepareEvents() {
    Set<PositionableEvent> events = _retrieveEvents();
    events = _removeAllDayEvents(events);
    events = _filterEvents(events);
    events = _extractFullyVisibleEvents(context, events);

    return events;
  }

  Set<PositionableEvent> _retrieveEvents() {
    DateTime date = DayViewDate.of(context).date;

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

class _ItemsBuilder {
  _ItemsBuilder({
    @required this.context,
    @required this.arranger,
    @required this.positioner,
    @required this.itemBuilder,
    @required this.events,
  })  : assert(context != null),
        assert(arranger != null),
        assert(positioner != null),
        assert(itemBuilder != null),
        assert(events != null);

  final BuildContext context;

  final EventsArranger arranger;

  final DayViewPositioner positioner;

  final EventBuilder itemBuilder;

  final Set<PositionableEvent> events;

  List<Positioned> makeItems() {
    List<ArrangedEvent> arrangedEvents = arranger.arrangeEvents(
      events: events,
      constraints: _makeArrangerConstraints(),
    );

    return _buildArrangedEvents(arrangedEvents);
  }

  List<Positioned> _buildArrangedEvents(List<ArrangedEvent> arrangedEvents) {
    return arrangedEvents
        .map((arrangedEvent) => itemBuilder(
              context: context,
              position: new Position(
                top: arrangedEvent.top + positioner.eventsAreaTop,
                left: arrangedEvent.left + positioner.eventsAreaLeft,
              ),
              size: new Size(
                arrangedEvent.width,
                arrangedEvent.height,
              ),
              event: arrangedEvent.event,
            ))
        .toList();
  }

  ArrangerConstraints _makeArrangerConstraints() {
    return new ArrangerConstraints(
      areaWidth: positioner.eventsAreaWidth,
      areaHeight: positioner.eventsAreaHeight,
      positionTopOf: positioner.minuteOfDayFromTopInsideEventsArea,
      heightOf: positioner.heightOfMinutes,
    );
  }
}

part of one_time_events_builder;

class _SingleDateEventsBuilder {
  _SingleDateEventsBuilder({
    @required this.context,
    @required this.dayNumber,
    @required this.arranger,
    @required this.positioner,
    @required this.itemBuilder,
    @required this.events,
  })  : assert(context != null),
        assert(dayNumber != null),
        assert(arranger != null),
        assert(positioner != null),
        assert(itemBuilder != null),
        assert(events != null);

  final BuildContext context;

  final int dayNumber;

  final EventsArranger arranger;
  final DayViewPositioner positioner;
  final EventBuilder itemBuilder;

  final Set<PositionableEvent> events;

  List<Positioned> buildEvents() {
    List<ArrangedEvent> arrangedEvents = _makeArrangedEvents();
    return _buildArrangedEvents(arrangedEvents);
  }

  List<ArrangedEvent> _makeArrangedEvents() {
    return arranger.arrangeEvents(
      events: events,
      constraints: _makeArrangerConstraints(),
    );
  }

  List<Positioned> _buildArrangedEvents(List<ArrangedEvent> arrangedEvents) {
    return arrangedEvents
        .map(
          (arrangedEvent) => _buildArrangedEvent(arrangedEvent),
        )
        .toList();
  }

  Positioned _buildArrangedEvent(ArrangedEvent arrangedEvent) {
    return itemBuilder(
      context: context,
      position: _makePositionOfArrangedEvent(arrangedEvent),
      size: _makeSizeOfArrangedEvent(arrangedEvent),
      event: arrangedEvent.event,
    );
  }

  ArrangerConstraints _makeArrangerConstraints() {
    return new ArrangerConstraints(
      areaWidth: positioner.dayAreWidth,
      areaHeight: positioner.dayAreaHeight,
      positionTopOf: (int minuteOfDay) {
        return positioner.minuteOfDayInsideDayArea(dayNumber, minuteOfDay);
      },
      heightOf: positioner.heightOfMinutes,
    );
  }

  Position _makePositionOfArrangedEvent(ArrangedEvent arrangedEvent) {
    return new Position(
      top: arrangedEvent.top + positioner.dayAreaTop(dayNumber),
      left: arrangedEvent.left + positioner.dayAreLeft(dayNumber),
    );
  }

  Size _makeSizeOfArrangedEvent(ArrangedEvent arrangedEvent) {
    return new Size(
      arrangedEvent.width,
      arrangedEvent.height,
    );
  }
}

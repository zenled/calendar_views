part of support_lines_component;

/// [DayViewComponent] that builds SupportLines at specific [interval]s starting at [minuteOfDayOfFirstSupportLine].
class IntervalSupportLineComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a SupportLine every [interval] minutes starting at [minuteOfDayOfFirstSupportLine].
  const IntervalSupportLineComponent({
    this.minuteOfDayOfFirstSupportLine = 0,
    @required this.interval,
    this.itemBuilder = supportLineItemBuilder,
  })  : assert(minuteOfDayOfFirstSupportLine != null &&
            minuteOfDayOfFirstSupportLine >= minimum_minute_of_day &&
            minuteOfDayOfFirstSupportLine <= maximum_minute_of_day),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a SupportLine for every full hour.
  factory IntervalSupportLineComponent.everyHour({
    SupportLineBuilder itemBuilder,
  }) {
    if (itemBuilder != null) {
      return new IntervalSupportLineComponent(
        interval: 60,
        itemBuilder: itemBuilder,
      );
    } else {
      return new IntervalSupportLineComponent(
        interval: 60,
      );
    }
  }

  /// Minute of day of first Support line.
  final int minuteOfDayOfFirstSupportLine;

  /// Minutes between SupportLines.
  final int interval;

  /// Function that builds a SupportLine.
  final SupportLineBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    _ItemCreator itemCreator = new _ItemCreator(
      context: context,
      restrictions: DayViewRestrictions.of(context),
      positions: DayViewPositions.of(context),
      itemBuilder: itemBuilder,
    );

    for (int minuteOfDay = minuteOfDayOfFirstSupportLine;
        minuteOfDay <= DayViewRestrictions.of(context).maximumMinuteOfDay;
        minuteOfDay += interval) {
      if (!itemCreator.canItemBeBuilt(minuteOfDay)) {
        continue;
      }

      items.add(
        itemCreator.buildItem(
          _createItemProperties(minuteOfDay: minuteOfDay),
        ),
      );
    }

    return items;
  }

  SupportLineProperties _createItemProperties({
    @required int minuteOfDay,
  }) {
    return new SupportLineProperties(
      minuteOfDay: minuteOfDay,
    );
  }
}

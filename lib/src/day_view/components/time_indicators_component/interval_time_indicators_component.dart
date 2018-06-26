part of time_indicators_component;

/// [DayViewComponent] that builds TimeIndicators at specific [interval]s starting at [minuteOfDayOfFirstTimeIndicator].
@immutable
class IntervalTimeIndicatorsComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a TimeIndicator every [interval] minutes starting at [minuteOfDayOfFirstTimeIndicator].
  const IntervalTimeIndicatorsComponent({
    this.minuteOfDayOfFirstTimeIndicator = 0,
    @required this.interval,
    this.itemBuilder = timeIndicatorItemBuilder,
  })  : assert(minuteOfDayOfFirstTimeIndicator != null &&
            minuteOfDayOfFirstTimeIndicator >= minimum_minute_of_day &&
            minuteOfDayOfFirstTimeIndicator <= maximum_minute_of_day),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a TimeIndicator for every full hour.
  factory IntervalTimeIndicatorsComponent.everyHour({
    TimeIndicatorBuilder itemBuilder,
  }) {
    if (itemBuilder != null) {
      return new IntervalTimeIndicatorsComponent(
        interval: 60,
        itemBuilder: itemBuilder,
      );
    } else {
      return new IntervalTimeIndicatorsComponent(
        interval: 60,
      );
    }
  }

  /// Minute of day of first TimeIndicator.
  final int minuteOfDayOfFirstTimeIndicator;

  /// Minutes between TimeIndicators.
  final int interval;

  /// Function that builds a TimeIndicator.
  final TimeIndicatorBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    _ItemCreator itemCreator = new _ItemCreator(
      context: context,
      restrictions: DayViewRestrictions.of(context),
      positions: DayViewPositions.of(context),
      itemBuilder: itemBuilder,
    );

    for (int minuteOfDay = minuteOfDayOfFirstTimeIndicator;
        minuteOfDay <= DayViewRestrictions.of(context).maximumMinuteOfDay;
        minuteOfDay += interval) {
      if (!itemCreator._isItemVisible(minuteOfDay)) {
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

  TimeIndicatorProperties _createItemProperties({
    @required int minuteOfDay,
  }) {
    return new TimeIndicatorProperties(
      minuteOfDay: minuteOfDay,
      duration: interval,
    );
  }
}

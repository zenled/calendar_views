import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/utils/all.dart';

import '../../dimensions_positions/day_view_positions.dart';
import '../../restrictions/all.dart';
import '../day_view_component.dart';
import 'time_indicator_builder.dart';
import 'time_indicator_properties.dart';

/// [DayViewComponent] that builds TimeIndicators at specific [interval]s starting at [minuteOfDayOfFirstTimeIndicator].
@immutable
class IntervalTimeIndicatorsComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a TimeIndicator every [interval] minutes starting at [minuteOfDayOfFirstTimeIndicator].
  const IntervalTimeIndicatorsComponent({
    this.minuteOfDayOfFirstTimeIndicator = 0,
    @required this.interval,
    this.itemBuilder = timeIndicatorItemBuilder,
  })  : assert(minuteOfDayOfFirstTimeIndicator != null &&
            minuteOfDayOfFirstTimeIndicator >= 0 &&
            minuteOfDayOfFirstTimeIndicator <= (24 * 60)),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a TimeIndicator for every full hour.
  factory IntervalTimeIndicatorsComponent.everyHour({
    TimeIndicatorBuilder itemBuilder,
  }) {
    return new IntervalTimeIndicatorsComponent(
      interval: 60,
      itemBuilder: itemBuilder,
    );
  }

  /// Minute of day of first TimeIndicator.
  final int minuteOfDayOfFirstTimeIndicator;

  /// Minutes between TimeIndicators.
  final int interval;

  /// Function that builds TimeIndicators.
  final TimeIndicatorBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    DayViewRestrictions restrictions = DayViewRestrictions.of(context);
    DayViewPositions positions = DayViewPositions.of(context);

    for (int minuteOfDay = minuteOfDayOfFirstTimeIndicator;
        minuteOfDay <= DayViewRestrictions.of(context).maximumMinuteOfDay;
        minuteOfDay += interval) {
      // skip items that are not visible
      if (minuteOfDay < restrictions.minimumMinuteOfDay ||
          minuteOfDay > restrictions.maximumMinuteOfDay) {
        continue;
      }

      Position itemLocation = new Position(
        top: positions.minuteOfDayFromTop(minuteOfDay - (interval ~/ 2)),
        left: positions.timeIndicationAreaLeft,
      );

      Size itemSize = new Size(
        positions.dimensions.timeIndicationAreaWidth,
        positions.heightOfMinutes(interval),
      );

      TimeIndicatorProperties itemProperties = new TimeIndicatorProperties(
        minuteOfDay: minuteOfDay,
        duration: interval,
      );

      items.add(itemBuilder(
        context: context,
        position: itemLocation,
        size: itemSize,
        properties: itemProperties,
      ));
    }
    return items;
  }
}

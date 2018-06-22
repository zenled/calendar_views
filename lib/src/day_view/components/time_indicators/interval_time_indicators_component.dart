import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/utils/all.dart';

import '../../dimensions_positions/day_view_positions.dart';
import '../../restrictions/all.dart';
import '../day_view_component.dart';
import 'time_indicator_builder.dart';
import 'time_indicator_properties.dart';

@immutable
class IntervalTimeIndicatorsComponent implements DayViewComponent {
  IntervalTimeIndicatorsComponent._internal({
    @required this.minuteOfDayOfFirstTimeIndicator,
    @required this.interval,
    @required this.itemBuilder,
  })  : assert(minuteOfDayOfFirstTimeIndicator != null &&
            isValidMinuteOfDay(minuteOfDayOfFirstTimeIndicator),),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  factory IntervalTimeIndicatorsComponent.everyXMinutes({
    int minuteOfDayOfFirstIndicator = 0,
    @required int interval,
    TimeIndicatorBuilder itemBuilder,
  }) {
    itemBuilder ??= timeIndicatorItemBuilder;

    return new IntervalTimeIndicatorsComponent._internal(
      minuteOfDayOfFirstTimeIndicator: minuteOfDayOfFirstIndicator,
      interval: interval,
      itemBuilder: itemBuilder,
    );
  }

  factory IntervalTimeIndicatorsComponent.everyHour({
    int startingHour = 0,
    TimeIndicatorBuilder itemBuilder,
  }) {
    return new IntervalTimeIndicatorsComponent.everyXMinutes(
      minuteOfDayOfFirstIndicator: startingHour * 60,
      interval: 60,
      itemBuilder: itemBuilder,
    );
  }

  /// Minute of day of first time indicator.
  final int minuteOfDayOfFirstTimeIndicator;

  /// Minutes between time indicators.
  final int interval;

  /// Function that builds timeIndicators.
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

      Location itemLocation = new Location(
        top: positions.minuteOfDayTop(minuteOfDay - (interval ~/ 2)),
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
        location: itemLocation,
        size: itemSize,
        properties: itemProperties,
      ));
    }
    return items;
  }
}

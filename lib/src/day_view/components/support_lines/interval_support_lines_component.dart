import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/utils/all.dart';

import '../../dimensions_positions/all.dart';
import '../../restrictions/all.dart';
import '../day_view_component.dart';
import 'support_line_builder.dart';

class IntervalSupportLineComponent implements DayViewComponent {
  IntervalSupportLineComponent._internal({
    @required this.minuteOfDayOfFirstSupportLine,
    @required this.interval,
    @required this.itemBuilder,
  })  : assert(minuteOfDayOfFirstSupportLine != null &&
            isValidMinuteOfDay(minuteOfDayOfFirstSupportLine)),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  factory IntervalSupportLineComponent.everyXMinutes({
    int minuteOfDayOfFirstSupportLine = 0,
    @required int interval,
    SupportLineBuilder itemBuilder,
  }) {
    itemBuilder ??= supportLineItemBuilder;

    return new IntervalSupportLineComponent._internal(
      minuteOfDayOfFirstSupportLine: minuteOfDayOfFirstSupportLine,
      interval: interval,
      itemBuilder: itemBuilder,
    );
  }

  factory IntervalSupportLineComponent.everyHour({
    int startingHour = 0,
    SupportLineBuilder itemBuilder,
  }) {
    return new IntervalSupportLineComponent.everyXMinutes(
      minuteOfDayOfFirstSupportLine: startingHour * 60,
      interval: 60,
      itemBuilder: itemBuilder,
    );
  }

  /// Minute of day of first support line.
  final int minuteOfDayOfFirstSupportLine;

  /// Minutes between supportLines.
  final int interval;

  /// Function that builds the support line.
  final SupportLineBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    DayViewRestrictions restrictions = DayViewRestrictions.of(context);
    DayViewPositions positions = DayViewPositions.of(context);

    for (int minuteOfDay = minuteOfDayOfFirstSupportLine;
        minuteOfDay <= restrictions.maximumMinuteOfDay;
        minuteOfDay += interval) {
      // skip items that are not visible
      if (minuteOfDay < restrictions.minimumMinuteOfDay ||
          minuteOfDay > restrictions.maximumMinuteOfDay) {
        continue;
      }

      Position itemLocation = new Position(
        top: positions.minuteOfDayTop(minuteOfDay),
        left: positions.contentAreaLeft,
      );

      double itemWidth = positions.contentAreaWidth;

      items.add(
        itemBuilder(
          context: context,
          position: itemLocation,
          width: itemWidth,
          minuteOfDay: minuteOfDay,
        ),
      );
    }

    return items;
  }
}

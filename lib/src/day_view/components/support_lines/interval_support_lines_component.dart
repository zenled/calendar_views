import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/utils/all.dart';

import '../../dimensions_positions/all.dart';
import '../../restrictions/all.dart';
import '../day_view_component.dart';
import 'support_line_builder.dart';

/// [DayViewComponent] that builds SupportLines at specific [interval]s starting at [minuteOfDayOfFirstSupportLine].
class IntervalSupportLineComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a SupportLine every [interval] minutes starting at [minuteOfDayOfFirstSupportLine].
  const IntervalSupportLineComponent({
    this.minuteOfDayOfFirstSupportLine = 0,
    @required this.interval,
    this.itemBuilder = supportLineItemBuilder,
  })  : assert(minuteOfDayOfFirstSupportLine != null &&
            minuteOfDayOfFirstSupportLine >= 0 &&
            minuteOfDayOfFirstSupportLine <= (24 * 60)),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a SupportLine for every full hour.
  factory IntervalSupportLineComponent.everyHour({
    SupportLineBuilder itemBuilder,
  }) {
    return new IntervalSupportLineComponent(
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
        top: positions.minuteOfDayFromTop(minuteOfDay),
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

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:flutter/material.dart';

/// Signature for a function that builds a [StartDurationItem] to be displayed as child of [DayViewSchedule].
typedef Positioned StartDurationItemBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  ItemSize itemSize,
);

/// Item with [startMinuteOfDay] and [duration] that can be provided to some implementations of [ScheduleComponent].
class StartDurationItem {
  StartDurationItem({
    required this.startMinuteOfDay,
    required this.duration,
    required this.builder,
  })   : assert(isMinuteOfDayValid(startMinuteOfDay)),
        assert(duration >= 0);

  /// Minute of day at which this item starts.
  final int startMinuteOfDay;

  /// Amount of minutes that this item occupies.
  final int duration;

  /// Function that builds this item.
  final StartDurationItemBuilder builder;
}

/// Signature for a function that builds a [TimeItem] to be displayed as child of [DayViewSchedule].
typedef Positioned TimeItemBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  double itemWidth,
);

/// Item with [minuteOfDay]  that can be provided to some implementations of [ScheduleComponent].
class TimeItem {
  TimeItem({
    required this.minuteOfDay,
    required this.builder,
  }) : assert(isMinuteOfDayValid(minuteOfDay));

  /// Minuter of day at which this item happens.
  final int minuteOfDay;

  /// Function that builds this item.
  final TimeItemBuilder builder;
}

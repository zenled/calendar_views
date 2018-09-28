import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Signature for a function that builds a [StartDurationItem] to be displayed as child of [DayViewSchedule].
typedef Positioned StartDurationItemBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  ItemSize itemSize,
);

/// Item with [startMinuteOfDay] and [duration] that can be provided to some implementations of [ScheduleComponent].
class StartDurationItem {
  StartDurationItem({
    @required this.startMinuteOfDay,
    @required this.duration,
    @required this.builder,
  })  : assert(
            startMinuteOfDay != null && isMinuteOfDayValid(startMinuteOfDay)),
        assert(duration != null && duration >= 0),
        assert(builder != null);

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
    @required this.minuteOfDay,
    @required this.builder,
  })  : assert(minuteOfDay != null && isMinuteOfDayValid(minuteOfDay)),
        assert(builder != null);

  /// Minuter of day at which this item happens.
  final int minuteOfDay;

  /// Function that builds this item.
  final TimeItemBuilder builder;
}

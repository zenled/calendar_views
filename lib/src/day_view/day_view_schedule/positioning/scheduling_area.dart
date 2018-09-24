import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

typedef double MinuteOfDayFromTopCallback(int minuteOfDay);

typedef double HeightOfDurationCallback(int duration);

/// Information about an area inside [DayViewSchedule].
@immutable
@deprecated
class SchedulingArea {
  const SchedulingArea({
    @required this.size,
    @required this.left,
    @required this.right,
    @required this.top,
    @required this.bottom,
    @required this.minuteOfDayFromTop,
    @required this.heightOfDuration,
  })  : assert(size != null),
        assert(left != null),
        assert(right != null),
        assert(top != null),
        assert(bottom != null),
        assert(minuteOfDayFromTop != null),
        assert(heightOfDuration != null);

  /// Size of the area.
  final Size size;

  /// Position from the left edge of [DayViewSchedule].
  final double left;

  /// Position from the right edge of [DayViewSchedule].
  final double right;

  /// Position from the top edge of [DayViewSchedule].
  final double top;

  /// Position from the bottom edge of [DayViewSchedule].
  final double bottom;

  /// Returns position from top edge of this area for a given minute of day.
  final MinuteOfDayFromTopCallback minuteOfDayFromTop;

  /// Returns height occupied by an item with the given duration inside a this area.
  final HeightOfDurationCallback heightOfDuration;
}

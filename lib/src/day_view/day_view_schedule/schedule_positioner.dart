import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Object that assist in positioning component items inside a [DayViewSchedule].
@immutable
class SchedulePositioner extends HorizontalPositioner {
  SchedulePositioner({
    @required HorizontalPositioner horizontalPositioner,
    @required this.heightPerMinute,
    @required this.topExtensionHeight,
    @required this.bottomExtensionHeight,
  })  : assert(heightPerMinute != null && heightPerMinute > 0.0),
        assert(topExtensionHeight != null && topExtensionHeight >= 0.0),
        assert(bottomExtensionHeight != null && bottomExtensionHeight >= 0.0),
        super.fromHorizontalPositioner(horizontalPositioner);

  final double heightPerMinute;

  final double topExtensionHeight;
  final double bottomExtensionHeight;

  /// Returns height a [DayViewSchedule] should have.
  double get totalHeight =>
      topExtensionHeight +
      heightOfDuration(properties.totalNumberOfMinutes) +
      bottomExtensionHeight;

  /// Height that some item with the given [duration] should have.
  double heightOfDuration(int duration) {
    _throwArgumentErrorIfInvalidDuration(duration);

    return heightPerMinute * duration;
  }

  /// Distance (from top) of a given [minuteOfDay] inside a [DayViewSchedule].
  double minuteOfDayFromTop(int minuteOfDay) {
    _throwArgumentErrorIfInvalidMinuteOfDay(minuteOfDay);

    double r = topExtensionHeight;
    r += heightOfDuration(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return r;
  }

  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - properties.minimumMinuteOfDay;
  }

  void _throwArgumentErrorIfInvalidDuration(int duration) {
    if (duration < 0) {
      throw new ArgumentError.value(
        duration,
        "duration",
        "duration must not be < 0",
      );
    }
  }

  void _throwArgumentErrorIfInvalidMinuteOfDay(int minuteOfDay) {
    if (!isMinuteOfDayValid(minuteOfDay)) {
      throw new ArgumentError.value(
        minuteOfDay,
        "minuteOfDay",
        "invalid minute of day",
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Signature for a function that returns height that some item with the given [durationInMinutes] should have inside a [DayViewSchedule].
typedef double HeightOfDurationCallback(
  int durationInMinutes,
);

/// Signature for a function that returns the distance from top of the given [minuteOdDay] inside a [DayViewSchedule].
typedef double MinuteOfDayFromTopCallback(
  int minuteOfDay,
);

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

  /// Height occupied by a single minute inside a [DayViewSchedule].
  final double heightPerMinute;

  /// Height of the extension above the minimum minute of [DayViewSchedule].
  final double topExtensionHeight;

  /// Height of the extension below the maximum minute of [DayViewSchedule].
  final double bottomExtensionHeight;

  /// Height a [DayViewSchedule] should have.
  double get totalHeight =>
      topExtensionHeight +
      heightOfDuration(properties.totalNumberOfMinutes) +
      bottomExtensionHeight;

  /// Height that some item with the given [duration] should have inside a [DayViewSchedule].
  ///
  /// [duration] can be less than 0.
  double heightOfDuration(int duration) {
    return heightPerMinute * duration;
  }

  /// Distance from top of a given [minuteOfDay] inside a [DayViewSchedule].
  ///
  /// [minuteOfDay] can be less than 0.
  double minuteOfDayFromTop(int minuteOfDay) {
    double r = topExtensionHeight;
    r += heightOfDuration(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return r;
  }

  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - properties.minimumMinuteOfDay;
  }
}

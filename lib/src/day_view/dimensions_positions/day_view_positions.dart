import 'package:flutter/material.dart';

import 'day_view_dimensions.dart';

class DayViewPositions extends InheritedWidget {
  DayViewPositions({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required this.dimensions,
    @required Widget child,
  })  : assert(dimensions != null),
        super(child: child);

  /// Maximum minute of day DayView is allowed to display (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day DayView is allowed to display (inclusive).
  final int maximumMinuteOfDay;

  /// Dimensions used for calculating other dimensions_positions.
  final DayViewDimensions dimensions;

  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - minimumMinuteOfDay;
  }

  double heightOfMinutes(int minutes) {
    return dimensions.heightPerMinute * minutes;
  }

  double minuteOfDayLocation(int minuteOfDay) {
    assert(minuteOfDay != null);

    double location = dimensions.paddingTop;
    location += heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return location;
  }

  double get timeIndicationAreaLeft => dimensions.paddingStart;

  double get separationAreaLeft =>
      dimensions.paddingStart + dimensions.timeIndicationAreaWidth;

  double get eventsAreaExtendedStart =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth;

  double get eventsAreaLeft =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth +
      dimensions.eventsAreaStartMargin;

  @override
  bool updateShouldNotify(DayViewPositions oldWidget) {
    return oldWidget.minimumMinuteOfDay != minimumMinuteOfDay ||
        oldWidget.maximumMinuteOfDay != maximumMinuteOfDay ||
        oldWidget.dimensions != dimensions;
  }
}

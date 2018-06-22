import 'package:flutter/material.dart';

import 'day_view_dimensions.dart';

class DayViewPositions extends InheritedWidget {
  DayViewPositions({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required this.dayViewWidth,
    @required this.dimensions,
    @required Widget child,
  })  : assert(minimumMinuteOfDay != null),
        assert(maximumMinuteOfDay != null),
        assert(dayViewWidth != null && dayViewWidth >= 0),
        assert(dimensions != null),
        super(child: child);

  final int minimumMinuteOfDay;

  final int maximumMinuteOfDay;

  /// Width of child dayViews.
  final double dayViewWidth;

  /// Dimensions used for calculating other dimensions_positions.
  final DayViewDimensions dimensions;

  /// With that the DayView should take.
  double get width => dayViewWidth;

  /// Height that the DayView should take.
  double get height =>
      dimensions.paddingTop +
      heightOfMinutes(maximumMinuteOfDay - minimumMinuteOfDay) +
      dimensions.paddingBottom;

  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - minimumMinuteOfDay;
  }

  /// Height of [minutes] in DayView.
  double heightOfMinutes(int minutes) {
    return dimensions.heightPerMinute * minutes;
  }

  /// Location (from top) of [minuteOfDay] inside DayView.
  double minuteOfDayTop(int minuteOfDay) {
    assert(minuteOfDay != null);

    double location = dimensions.paddingTop;
    location += heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return location;
  }

  /// Leftmost location of timeIndicationArea.
  double get timeIndicationAreaLeft => dimensions.paddingStart;

  /// Leftmost location of separationArea.
  double get separationAreaLeft =>
      dimensions.paddingStart + dimensions.timeIndicationAreaWidth;

  /// Leftmost location of contentArea.
  double get contentAreaLeft =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth;

  /// Width of the content area.
  double get contentAreaWidth =>
      dayViewWidth -
      dimensions.paddingStart -
      dimensions.timeIndicationAreaWidth -
      dimensions.separationAreaWidth -
      dimensions.paddingEnd;

  /// Leftmost location of EventsArea.
  double get eventAreaLeft =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth +
      dimensions.eventsAreaStartMargin;

  @override
  bool updateShouldNotify(DayViewPositions oldWidget) {
    return oldWidget.minimumMinuteOfDay != minimumMinuteOfDay ||
        oldWidget.maximumMinuteOfDay != maximumMinuteOfDay ||
        oldWidget.width != width ||
        oldWidget.dimensions != dimensions;
  }

  static DayViewPositions of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewPositions);
  }
}

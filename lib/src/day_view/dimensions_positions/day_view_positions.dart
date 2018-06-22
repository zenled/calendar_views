import 'package:flutter/material.dart';

import 'day_view_dimensions.dart';

/// Widget that propagates key positions and sizing properties placed upon child DayViews.
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

  /// Width that child DayViews should occupy.
  final double dayViewWidth;

  /// Dimensions of key DayView components.
  final DayViewDimensions dimensions;

  /// With that the DayView should take.
  double get width => dayViewWidth;

  /// Height that the DayView should take.
  double get height =>
      dimensions.paddingTop +
      heightOfMinutes(maximumMinuteOfDay - minimumMinuteOfDay) +
      dimensions.paddingBottom;

  /// Returns number of minutes between [minimumMinuteOfDay] and [minuteOfDay].
  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - minimumMinuteOfDay;
  }

  /// Height of the area that should be taken by some item that lasts [minutes].
  double heightOfMinutes(int minutes) {
    return dimensions.heightPerMinute * minutes;
  }

  /// Location (from top) of a specific [minuteOfDay] inside DayView.
  double minuteOfDayFromTop(int minuteOfDay) {
    assert(minuteOfDay != null);

    double location = dimensions.paddingTop;
    location += heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return location;
  }

  // --- timeIndication area

  /// Leftmost location of TimeIndicationArea.
  double get timeIndicationAreaLeft => dimensions.paddingStart;

  /// Rightmost location of TimeIndicationArea.
  double get timeIndicationAreaRight =>
      timeIndicationAreaLeft + timeIndicationAreaWidth;

  /// Width of TimeIndicationArea.
  double get timeIndicationAreaWidth => dimensions.timeIndicationAreaWidth;

  // --- separation area

  /// Leftmost location of SeparationArea.
  double get separationAreaLeft =>
      dimensions.paddingStart + dimensions.timeIndicationAreaWidth;

  /// Rightmost location of separationArea.
  double get separationAreaRight => separationAreaLeft + separationAreaWidth;

  /// Width of SeparationArea.
  double get separationAreaWidth => dimensions.separationAreaWidth;

  // --- content area

  /// Leftmost location of ContentArea.
  double get contentAreaLeft =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth;

  /// Rightmost location of ContentArea.
  double get contentAreaRight => contentAreaLeft + contentAreaWidth;

  /// Width of ContentArea.
  double get contentAreaWidth =>
      dayViewWidth -
      dimensions.paddingStart -
      dimensions.timeIndicationAreaWidth -
      dimensions.separationAreaWidth -
      dimensions.paddingEnd;

  // --- events area

  /// Leftmost location of EventsArea.
  double get eventsAreaLeft =>
      dimensions.paddingStart +
      dimensions.timeIndicationAreaWidth +
      dimensions.separationAreaWidth +
      dimensions.eventsAreaStartMargin;

  /// Rightmost location of EventsArea.
  double get eventsAreaRight => eventsAreaLeft + eventAreaWidth;

  /// Width of EventsArea.
  double get eventAreaWidth =>
      dayViewWidth -
      dimensions.paddingStart -
      dimensions.timeIndicationAreaWidth -
      dimensions.separationAreaWidth -
      dimensions.eventsAreaStartMargin -
      dimensions.eventsAreaEndMargin -
      dimensions.paddingEnd;

  @override
  bool updateShouldNotify(DayViewPositions oldWidget) {
    return oldWidget.minimumMinuteOfDay != minimumMinuteOfDay ||
        oldWidget.maximumMinuteOfDay != maximumMinuteOfDay ||
        oldWidget.dayViewWidth != dayViewWidth ||
        oldWidget.dimensions != dimensions;
  }

  static DayViewPositions of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewPositions);
  }
}

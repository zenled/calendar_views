part of day_view_positions;

@immutable
class DayViewPositioner {
  DayViewPositioner({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required this.dimensions,
    @required this.width,
  })  : assert(minimumMinuteOfDay != null &&
            isValidMinuteOfDay(minimumMinuteOfDay)),
        assert(maximumMinuteOfDay != null &&
            isValidMinuteOfDay(maximumMinuteOfDay)),
        assert(minimumMinuteOfDay <= maximumMinuteOfDay),
        assert(dimensions != null),
        assert(width != null && width >= 0);

  final int minimumMinuteOfDay;

  final int maximumMinuteOfDay;

  /// Dimensions to acknowledge when positioning.
  final DayViewDimensions dimensions;

  /// Width of the whole positioning area.
  final double width;

  /// Height that the whole positioning area.
  double get height =>
      dimensions.paddingTop +
      heightOfMinutes(maximumMinuteOfDay - minimumMinuteOfDay) +
      dimensions.paddingBottom;

  /// Returns number of minutes between [minimumMinuteOfDay] and [minuteOfDay].
  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - minimumMinuteOfDay;
  }

  int _totalNumberOfMinutes() {
    return maximumMinuteOfDay - minimumMinuteOfDay;
  }

  /// Height of the area that should be taken by some item that lasts [minutes].
  double heightOfMinutes(int minutes) {
    return dimensions.heightPerMinute * minutes;
  }

  /// Location (from top) of a specific [minuteOfDay] inside DayView.
  double minuteOfDayFromTop(int minuteOfDay) {
    double location = dimensions.paddingTop;
    location += heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return location;
  }

  // TimeIndication area

  /// Leftmost location of TimeIndicationArea.
  double get timeIndicationAreaLeft => 0.0;

  /// Rightmost location of TimeIndicationArea.
  double get timeIndicationAreaRight =>
      timeIndicationAreaLeft + timeIndicationAreaWidth;

  /// Width of TimeIndicationArea.
  double get timeIndicationAreaWidth => dimensions.timeIndicationAreaWidth;

  // Separation area

  /// Leftmost location of SeparationArea.
  double get separationAreaLeft => timeIndicationAreaRight;

  /// Rightmost location of separationArea.
  double get separationAreaRight => separationAreaLeft + separationAreaWidth;

  /// Width of SeparationArea.
  double get separationAreaWidth => dimensions.separationAreaWidth;

  // Content area

  /// Leftmost location of ContentArea.
  double get contentAreaLeft => separationAreaRight;

  /// Rightmost location of ContentArea.
  double get contentAreaRight => contentAreaLeft + contentAreaWidth;

  /// Width of ContentArea.
  double get contentAreaWidth =>
      width -
      dimensions.timeIndicationAreaWidth -
      dimensions.separationAreaWidth;

  // Events area

  /// Leftmost location of EventsArea.
  double get eventsAreaLeft =>
      contentAreaLeft + dimensions.eventsAreaStartMargin;

  /// Rightmost location of EventsArea.
  double get eventsAreaRight => eventsAreaLeft + eventsAreaWidth;

  /// Topmost location of EventsArea.
  double get eventsAreaTop => dimensions.paddingTop;

  /// Bottommost location of EventsArea.
  double get eventsAreBottom => height - dimensions.paddingBottom;

  /// Width of EventsArea.
  double get eventsAreaWidth =>
      width -
      timeIndicationAreaWidth -
      separationAreaWidth -
      dimensions.eventsAreaStartMargin -
      dimensions.eventsAreaEndMargin;

  double get eventsAreaHeight => heightOfMinutes(
        _totalNumberOfMinutes(),
      );

  double minuteOfDayFromTopInsideEventsArea(int minuteOfDay) {
    return heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
  }
}

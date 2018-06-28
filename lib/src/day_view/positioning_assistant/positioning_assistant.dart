part of day_view_positions;

@immutable
class DayViewPositioner {
  DayViewPositioner({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required this.numberOfDays,
    @required this.dimensions,
    @required this.width,
  })  : assert(minimumMinuteOfDay != null &&
            isValidMinuteOfDay(minimumMinuteOfDay)),
        assert(maximumMinuteOfDay != null &&
            isValidMinuteOfDay(maximumMinuteOfDay)),
        assert(minimumMinuteOfDay <= maximumMinuteOfDay),
        assert(numberOfDays != null && numberOfDays > 0),
        assert(dimensions != null),
        assert(width != null && width >= 0);

  final int minimumMinuteOfDay;

  final int maximumMinuteOfDay;

  final int positioningAssistant;

  /// Number of days that this positioner can position.
  final int numberOfDays;

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
  double get eventsAreaBottom => height - dimensions.paddingBottom;

  /// Width of EventsArea.
  double get eventsAreaWidth =>
      width -
      timeIndicationAreaWidth -
      separationAreaWidth -
      dimensions.eventsAreaStartMargin -
      dimensions.eventsAreaEndMargin;

  /// Height of the EventsArea.
  double get eventsAreaHeight => heightOfMinutes(
        _totalNumberOfMinutes(),
      );

  double minuteOfDayFromTopInsideEventsArea(int minuteOfDay) {
    return heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
  }

  // Day area

  double dayAreLeft(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventsAreaLeft;
    r += dimensions.separationBetweenDays * dayNumber;
    r += dayAreWidth * dayNumber;
    return r;
  }

  double dayAreRight(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventsAreaRight;
    r -= dimensions.separationBetweenDays * dayNumber;
    r -= dayAreWidth * dayNumber;
    return r;
  }

  double dayAreaTop(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return eventsAreaTop;
  }

  double dayAreaBottom(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return eventsAreaBottom;
  }

  double minuteOfDayInsideDayArea(int dayNumber, int minuteOfDay) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
  }

  double get dayAreWidth {
    double r = eventsAreaWidth;
    // remove separation between days
    r -= (numberOfDays - 1) * dimensions.separationBetweenDays;
    // divide the rest of the are between days
    r /= numberOfDays;
    return r;
  }

  double get dayAreaHeight => eventsAreaHeight;

  void _throwArgumentErrorIfInvalidDayNumber(int dayNumber) {
    if (dayNumber >= numberOfDays) {
      throw new ArgumentError.value(
        dayNumber,
        "dayNumber",
        "DayNumber is greater that the ammount of days this positioner can position ($numberOfDays).",
      );
    }
    if (dayNumber < 0) {
      throw new ArgumentError.value(
        dayNumber,
        "dayNumber",
        "DayNumber must be greater or equal to 0.",
      );
    }
  }
}

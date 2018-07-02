import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/properties/all.dart';

@immutable
class PositioningAssistant {
  PositioningAssistant({
    @required this.days,
    @required this.dimensions,
    @required this.restrictions,
    @required this.sizeConstraints,
  })  : assert(days != null),
        assert(dimensions != null),
        assert(restrictions != null),
        assert(sizeConstraints != null);

  final Days days;
  final Dimensions dimensions;
  final Restrictions restrictions;
  final SizeConstraints sizeConstraints;

  /// Height of the area that should be taken by some item that lasts [minutes].
  double heightOfMinutes(int minutes) {
    return dimensions.heightPerMinute * minutes;
  }

  /// Location (from top) of a specific [minuteOfDay] inside DayView.
  double minuteOfDayFromTop(int minuteOfDay) {
    double location = dimensions.topExtension;
    location += heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
    return location;
  }

  // total Size ----------------------------------------------------------------

  double get totalAreaWidth => sizeConstraints.availableWidth;

  /// Height that the whole positioning area.
  double get totalAreaHeight =>
      dimensions.topExtension +
      heightOfMinutes(_totalNumberOfMinutes) +
      dimensions.bottomExtension;

  Size get totalSize => new Size(totalAreaWidth, totalAreaHeight);

  double get totalAreaLeft => 0.0;

  double get totalAreaRight => totalAreaLeft + totalAreaWidth;

  double get totalAreaTop => 0.0;

  double get totalAreaBottom => totalAreaTop + totalAreaHeight;

  double minuteOfDayFromTopInsideTotalArea(int minuteOfDay) {
    double r = dimensions.topExtension;
    r += heightOfMinutes(_minutesFromMinimumMinute(minuteOfDay));
    return r;
  }

  // TimeIndication area -------------------------------------------------------

  /// Width of TimeIndicationArea.
  double get timeIndicationAreaWidth => dimensions.timeIndicationAreaWidth;

  double get timeIndicationAreHeight => totalAreaHeight;

  Size get timeIndicationAreaSize =>
      new Size(timeIndicationAreaWidth, timeIndicationAreHeight);

  /// Leftmost location of TimeIndicationArea.
  double get timeIndicationAreaLeft => 0.0;

  /// Rightmost location of TimeIndicationArea.
  double get timeIndicationAreaRight =>
      timeIndicationAreaLeft + timeIndicationAreaWidth;

  double get timeIndicationAreaTop => 0.0;

  double get timeIndicationAreaBottom => totalAreaWidth;

  double minuteOfDayFromTopInsideTimeIndicationArea(int minuteOfDay) {
    return minuteOfDayFromTopInsideTotalArea(minuteOfDay);
  }

  // Separation area -----------------------------------------------------------

  /// Width of SeparationArea.
  double get separationAreaWidth => dimensions.separationAreaWidth;

  double get separationAreaHeight => totalAreaHeight;

  Size get separationAreaSize =>
      new Size(separationAreaWidth, separationAreaHeight);

  /// Leftmost location of SeparationArea.
  double get separationAreaLeft => timeIndicationAreaRight;

  /// Rightmost location of separationArea.
  double get separationAreaRight => separationAreaLeft + separationAreaWidth;

  double get separationAreaTop => 0.0;

  double get separationAreaBottom => totalAreaHeight;

  double minuteOfDayFromTopInsideSeparationArea(int minuteOfDay) {
    return minuteOfDayFromTopInsideTotalArea(minuteOfDay);
  }

  // Content area --------------------------------------------------------------

  /// Width of ContentArea.
  double get contentAreaWidth =>
      totalAreaWidth - timeIndicationAreaWidth - separationAreaWidth;

  double get contentAreaHeight => totalAreaHeight;

  Size get contentAreaSize => new Size(contentAreaWidth, contentAreaHeight);

  /// Leftmost location of ContentArea.
  double get contentAreaLeft => separationAreaRight;

  double get contentAreaRight => contentAreaLeft + contentAreaWidth;

  double get contentAreaTop => 0.0;

  double get contentAreaBottom => totalAreaHeight;

  double minuteOfDayFromTopInsideContentArea(int minuteOfDay) {
    return minuteOfDayFromTopInsideTotalArea(minuteOfDay);
  }

  // Events area ---------------------------------------------------------------

  /// Width of EventsArea.
  double get eventsAreaWidth =>
      totalAreaWidth -
      timeIndicationAreaWidth -
      separationAreaWidth -
      dimensions.eventsAreaStartMargin -
      dimensions.eventsAreaEndMargin;

  /// Height of the EventsArea.
  double get eventsAreaHeight =>
      totalAreaHeight - dimensions.topExtension - dimensions.bottomExtension;

  Size get eventsAreaSize => new Size(eventsAreaWidth, eventsAreaHeight);

  /// Leftmost location of EventsArea.
  double get eventsAreaLeft =>
      contentAreaLeft + dimensions.eventsAreaStartMargin;

  /// Rightmost location of EventsArea.
  double get eventsAreaRight => eventsAreaLeft + eventsAreaWidth;

  /// Topmost location of EventsArea.
  double get eventsAreaTop => dimensions.topExtension;

  /// Bottommost location of EventsArea.
  double get eventsAreaBottom => eventsAreaTop + eventsAreaHeight;

  double minuteOfDayFromTopInsideEventsArea(int minuteOfDay) {
    return heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
  }

  // Day area ------------------------------------------------------------------

  double dayAreaWidth(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventsAreaWidth;
    // remove separation between days
    r -= (_numberOfDays - 1) * dimensions.daySeparation;
    // divide the rest of the are between days
    r /= _numberOfDays;
    return r;
  }

  double dayAreaHeight(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return eventsAreaHeight;
  }

  Size dayAreaSize(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return new Size(dayAreaWidth(dayNumber), dayAreaHeight(dayNumber));
  }

  double dayAreaLeft(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventsAreaLeft;
    r += dimensions.daySeparation * dayNumber;
    r += dayAreaWidth(dayNumber) * dayNumber;
    return r;
  }

  double dayAreaRight(int dayNumber) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = dayAreaLeft(dayNumber);
    r += dayAreaWidth(dayNumber);
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

  double minuteOfDayFromTopInsideDayArea(int dayNumber, int minuteOfDay) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return minuteOfDayFromTopInsideEventsArea(minuteOfDay);
  }

  // Day Separation Area -------------------------------------------------------

  double daySeparationAreaWidth(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dimensions.daySeparation;
  }

  double daySeparationAreaHeight(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return eventsAreaHeight;
  }

  Size daySeparationAreaSize(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return new Size(
      daySeparationAreaWidth(daySeparationNumber),
      daySeparationAreaHeight(daySeparationNumber),
    );
  }

  double daySeparationAreaLeft(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dayAreaRight(daySeparationNumber);
  }

  double daySeparationAreaRight(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    double r = 0.0;
    r = daySeparationAreaLeft(daySeparationNumber);
    r += daySeparationAreaWidth(daySeparationNumber);
    return r;
  }

  double daySeparationAreaTop(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return eventsAreaTop;
  }

  double daySeparationAreaBottom(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return eventsAreaBottom;
  }

  double minuteOfDayFromTopInsideDaySeparationArea(
    int daySeparationNumber,
    int minuteOfDay,
  ) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return minuteOfDayFromTopInsideDayArea(daySeparationNumber, minuteOfDay);
  }

  // Extended Day Separation Area ----------------------------------------------

  double extendedDaySeparationAreaWidth(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dimensions.daySeparation;
  }

  double extendedDaySeparationAreaHeight(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return contentAreaHeight;
  }

  Size extendedDaySeparationAreaSize(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return new Size(
      extendedDaySeparationAreaWidth(daySeparationNumber),
      extendedDaySeparationAreaHeight(daySeparationNumber),
    );
  }

  double extendedDaySeparationAreaLeft(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dayAreaRight(daySeparationNumber);
  }

  double extendedDaySeparationAreaRight(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    double r = 0.0;
    r = daySeparationAreaLeft(daySeparationNumber);
    r += daySeparationAreaWidth(daySeparationNumber);
    return r;
  }

  double extendedDaySeparationAreaTop(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return contentAreaTop;
  }

  double extendedDaySeparationAreaBottom(int daySeparationNumber) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return contentAreaBottom;
  }

  double minuteOfDayFromTopInsideExtendedDaySeparationArea(
    int daySeparationNumber,
    int minuteOfDay,
  ) {
    _throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    double r = daySeparationAreaTop(daySeparationNumber);
    r += minuteOfDayFromTopInsideDaySeparationArea(
        daySeparationNumber, minuteOfDay);
    return r;
  }

  // ---------------------------------------------------------------------------

  int get _totalNumberOfMinutes => restrictions.totalNumberOfMinutes;

  int get _numberOfDays => days.numberOfDays;

  int get _numberOfDaySeparations => _numberOfDays - 1;

  void _throwArgumentErrorIfInvalidDayNumber(int dayNumber) {
    if (dayNumber >= _numberOfDays) {
      throw new ArgumentError.value(
        dayNumber,
        "dayNumber",
        "DayNumber is greater that the ammount of days this PositioningAssistant can position ($_numberOfDays).",
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

  void _throwArgumentErrorIfInvalidDaySeparationNumber(
      int daySeparationNumber) {
    if (daySeparationNumber >= _numberOfDaySeparations) {
      throw new ArgumentError.value(
        daySeparationNumber,
        "daySeparationNumber",
        "There are numberOfDays -1 daySeparations (number of day separations: $_numberOfDaySeparations)",
      );
    }
    if (daySeparationNumber < 0) {
      throw new ArgumentError.value(
        daySeparationNumber,
        "daySeparationNumber",
        "DaySeparationNumber must be greater or equal to 0",
      );
    }
  }

  /// Returns number of minutes between [minimumMinuteOfDay] and [minuteOfDay].
  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - restrictions.minimumMinuteOfDay;
  }
}

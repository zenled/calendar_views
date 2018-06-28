import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/properties/all.dart';

@immutable
class PositioningAssistant {
  PositioningAssistant({
    @required this.dates,
    @required this.dimensions,
    @required this.restrictions,
    @required this.sizes,
  })  : assert(dates != null),
        assert(dimensions != null),
        assert(restrictions != null),
        assert(sizes != null);

  final Dates dates;
  final Dimensions dimensions;
  final Restrictions restrictions;
  final Sizes sizes;

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

  double get totalAreaWidth => sizes.totalAvailableWidth;

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
    _throwArgumentErrorIfInvalidMinuteOfDay(minuteOfDay);

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
    _throwArgumentErrorIfInvalidMinuteOfDay(minuteOfDay);

    return heightOfMinutes(
      _minutesFromMinimumMinute(minuteOfDay),
    );
  }

  // Day area ------------------------------------------------------------------

  double get dayAreWidth {
    double r = eventsAreaWidth;
    // remove separation between days
    r -= (_numberOfDays - 1) * dimensions.separationBetweenDays;
    // divide the rest of the are between days
    r /= _numberOfDays;
    return r;
  }

  double get dayAreaHeight => eventsAreaHeight;

  Size get dayAreaSize => new Size(dayAreWidth, dayAreaHeight);

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

  double minuteOfDayFromTopInsideDayArea(int dayNumber, int minuteOfDay) {
    _throwArgumentErrorIfInvalidDayNumber(dayNumber);
    _throwArgumentErrorIfInvalidMinuteOfDay(minuteOfDay);

    return minuteOfDayFromTopInsideEventsArea(minuteOfDay);
  }

  // ---------------------------------------------------------------------------

  int get _totalNumberOfMinutes => restrictions.totalNumberOfMinutes;

  int get _numberOfDays => dates.numberOfDates;

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

  void _throwArgumentErrorIfInvalidMinuteOfDay(int minuteOfDay) {
    if (minuteOfDay < restrictions.minimumMinuteOfDay) {
      throw new ArgumentError.value(
          minuteOfDay,
          "minuteOfDay",
          "MinuteOfDay is lower than minimumMinuteOfDay (${restrictions
              .minimumMinuteOfDay})");
    }
    if (minuteOfDay > restrictions.maximumMinuteOfDay) {
      throw new ArgumentError.value(
        minuteOfDay,
        "minuteOfDay",
        "MinuteOfDay is greate than maximumMinuteOfDay (${restrictions
            .maximumMinuteOfDay}",
      );
    }
  }

  /// Returns number of minutes between [minimumMinuteOfDay] and [minuteOfDay].
  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - restrictions.minimumMinuteOfDay;
  }
}

import 'package:meta/meta.dart';

import 'day_view_area.dart';
import 'day_view_properties.dart';
import 'day_view_widths.dart';

/// Assistant for horizontal positioning for day view widgets.
@immutable
class HorizontalPositioner {
  HorizontalPositioner({
    @required this.properties,
    @required this.widths,
    @required this.totalWidth,
  })  : assert(properties != null),
        assert(widths != null),
        assert(totalWidth != null && totalWidth >= 0);

  HorizontalPositioner.fromHorizontalPositioner(
    HorizontalPositioner horizontalPositioner,
  )   : assert(horizontalPositioner != null),
        properties = horizontalPositioner.properties,
        widths = horizontalPositioner.widths,
        totalWidth = horizontalPositioner.totalWidth;

  final DayViewProperties properties;

  final DayViewWidths widths;

  /// Total width that [HorizontalPositioner] can position within.
  final double totalWidth;

  double getNonNumberedAreaWidth(DayViewArea area) {
    switch (area) {
      case DayViewArea.totalArea:
        return totalAreaWidth;
      case DayViewArea.startTotalArea:
        return startTotalAreaWidth;
      case DayViewArea.endTotalArea:
        return endTotalAreaWidth;
      case DayViewArea.contentArea:
        return contentAreaWidth;
      case DayViewArea.timeIndicationArea:
        return timeIndicationAreaWidth;
      case DayViewArea.separationArea:
        return separationAreaWidth;
      case DayViewArea.mainArea:
        return mainAreaWidth;
      case DayViewArea.startMainArea:
        return startMainAreaWidth;
      case DayViewArea.endMainArea:
        return endMainAreaWidth;
      case DayViewArea.eventArea:
        return eventAreaWidth;
      default:
        throw new Exception(
          "$area is not a non-numbered area, try using getNumberedAreaWidth",
        );
    }
  }

  double getNonNumberedAreaLeft(DayViewArea area) {
    switch (area) {
      case DayViewArea.totalArea:
        return totalAreaLeft;
      case DayViewArea.startTotalArea:
        return startTotalAreaLeft;
      case DayViewArea.endTotalArea:
        return endTotalAreaLeft;
      case DayViewArea.contentArea:
        return contentAreaLeft;
      case DayViewArea.timeIndicationArea:
        return timeIndicationAreaLeft;
      case DayViewArea.separationArea:
        return separationAreaLeft;
      case DayViewArea.mainArea:
        return mainAreaLeft;
      case DayViewArea.startMainArea:
        return startMainAreaLeft;
      case DayViewArea.endMainArea:
        return endMainAreaLeft;
      case DayViewArea.eventArea:
        return eventAreaLeft;
      default:
        throw new Exception(
          "$area is not a non-numbered area, try using getNumberedAreaLeft",
        );
    }
  }

  double getNonNumberedAreaRight(DayViewArea area) {
    switch (area) {
      case DayViewArea.totalArea:
        return totalAreaRight;
      case DayViewArea.startTotalArea:
        return startTotalAreaRight;
      case DayViewArea.endTotalArea:
        return endTotalAreaRight;
      case DayViewArea.contentArea:
        return contentAreaRight;
      case DayViewArea.timeIndicationArea:
        return timeIndicationAreaRight;
      case DayViewArea.separationArea:
        return separationAreaRight;
      case DayViewArea.mainArea:
        return mainAreaRight;
      case DayViewArea.startMainArea:
        return startMainAreaRight;
      case DayViewArea.endMainArea:
        return endMainAreaRight;
      case DayViewArea.eventArea:
        return eventAreaRight;
      default:
        throw new Exception(
          "$area is not a non-numbered area, try using getNumberedAreaRight",
        );
    }
  }

  double getNumberedAreaWidth(DayViewArea area, int areaNumber) {
    switch (area) {
      case DayViewArea.dayArea:
        return dayAreaWidth(areaNumber);
      case DayViewArea.separationArea:
        return daySeparationAreaWidth(areaNumber);
      default:
        throw new Exception(
          "$area is a non-numbered area, try usin getNonNumberedAreaWidth",
        );
    }
  }

  double getNumberedAreaLeft(DayViewArea area, int areaNumber) {
    switch (area) {
      case DayViewArea.dayArea:
        return dayAreaLeft(areaNumber);
      case DayViewArea.separationArea:
        return daySeparationAreaLeft(areaNumber);
      default:
        throw new Exception(
          "$area is a non-numbered area, try usin getNonNumberedAreaLeft",
        );
    }
  }

  double getNumberedAreaRight(DayViewArea area, int areaNumber) {
    switch (area) {
      case DayViewArea.dayArea:
        return dayAreaRight(areaNumber);
      case DayViewArea.separationArea:
        return daySeparationAreaRight(areaNumber);
      default:
        throw new Exception(
          "$area is a non-numbered area, try usin getNonNumberedAreaRight",
        );
    }
  }

  // totalArea -----------------------------------------------------------------

  double get totalAreaWidth => totalWidth;

  double get totalAreaLeft => 0.0;

  double get totalAreaRight => totalAreaLeft + totalWidth;

  // startTotalArea ------------------------------------------------------------

  double get startTotalAreaWidth => widths.totalAreaStartPadding;

  double get startTotalAreaLeft => totalAreaLeft;

  double get startTotalAreaRight => startTotalAreaLeft + startTotalAreaWidth;

  // endTotalArea --------------------------------------------------------------

  double get endTotalAreaWidth => widths.totalAreaEndPadding;

  double get endTotalAreaLeft => totalAreaRight - endTotalAreaWidth;

  double get endTotalAreaRight => endTotalAreaLeft + endTotalAreaWidth;

  // contentArea ---------------------------------------------------------------

  double get contentAreaWidth =>
      totalAreaWidth - startTotalAreaWidth - endTotalAreaWidth;

  double get contentAreaLeft => startTotalAreaRight;

  double get contentAreaRight => contentAreaLeft + contentAreaWidth;

  // timeIndicationArea --------------------------------------------------------

  double get timeIndicationAreaWidth => widths.timeIndicationAreaWidth;

  double get timeIndicationAreaLeft => contentAreaLeft;

  double get timeIndicationAreaRight =>
      timeIndicationAreaLeft + timeIndicationAreaWidth;

  // separationArea ------------------------------------------------------------

  double get separationAreaWidth => widths.separationAreaWidth;

  double get separationAreaLeft => timeIndicationAreaRight;

  double get separationAreaRight => separationAreaLeft + separationAreaWidth;

  // mainArea ------------------------------------------------------------------

  double get mainAreaWidth => _minimumZero(
        contentAreaWidth - timeIndicationAreaWidth - separationAreaWidth,
      );

  double get mainAreaLeft => separationAreaRight;

  double get mainAreaRight => mainAreaLeft + mainAreaWidth;

  // startMainArea -------------------------------------------------------------

  double get startMainAreaWidth => widths.mainAreaStartPadding;

  double get startMainAreaLeft => mainAreaLeft;

  double get startMainAreaRight => startMainAreaLeft + startMainAreaWidth;

  // endMainArea ---------------------------------------------------------------

  double get endMainAreaWidth => widths.mainAreaEndPadding;

  double get endMainAreaLeft => mainAreaRight - endMainAreaWidth;

  double get endMainAreaRight => endMainAreaLeft + endMainAreaWidth;

  // eventArea -----------------------------------------------------------------

  double get eventAreaWidth => _minimumZero(
        mainAreaWidth - startMainAreaWidth - endMainAreaWidth,
      );

  double get eventAreaLeft => startMainAreaRight;

  double get eventAreaRight => eventAreaLeft + eventAreaWidth;

  // dayArea -------------------------------------------------------------------

  double get _constantDayAreaWidth {
    double r = eventAreaWidth;
    r -= (properties.numberOfDaySeparations * _constantDaySeparationAreaWidth);
    r /= properties.numberOfDays;
    r = _minimumZero(r);
    return r;
  }

  double dayAreaWidth(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return _constantDayAreaWidth;
  }

  double dayAreaLeft(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventAreaLeft;
    r += dayNumber * _constantDaySeparationAreaWidth;
    r += dayNumber * _constantDayAreaWidth;
    return r;
  }

  double dayAreaRight(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return dayAreaLeft(dayNumber) + _constantDayAreaWidth;
  }

  // daySeparationArea ---------------------------------------------------------

  double get _constantDaySeparationAreaWidth => widths.daySeparationAreaWidth;

  double daySeparationAreaWidth(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return _constantDaySeparationAreaWidth;
  }

  double daySeparationAreaLeft(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dayAreaRight(daySeparationNumber);
  }

  double daySeparationAreaRight(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return daySeparationAreaLeft(daySeparationNumber) +
        _constantDaySeparationAreaWidth;
  }

  /// Returns the daySeparationNumber of [DayViewArea.daySeparationArea] that is to the left of the given day.
  ///
  /// If there is no day separation to the left of day it returns null.
  int daySeparationNumberLeftOfDay(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    if (isDaySeparationLeftOfDay(dayNumber)) {
      return dayNumber - 1;
    } else {
      return null;
    }
  }

  /// Returns the daySeparationNumber of [DayViewArea.daySeparationArea] that is to the right of the given day.
  ///
  /// If there is no day separation to the right of day it returns null.
  int daySeparationNumberRightOfDay(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    if (isDaySeparationRightOfDay(dayNumber)) {
      return dayNumber;
    } else {
      return null;
    }
  }

  /// Returns true if there is a [DayViewArea.daySeparationArea] to the left of the given day.
  bool isDaySeparationLeftOfDay(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return dayNumber != 0;
  }

  /// Returns true if there is a [DayViewArea.daySeparationArea] to the right of the given day.
  bool isDaySeparationRightOfDay(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    if (properties.numberOfDays == 1) {
      return false;
    } else {
      return dayNumber < (properties.numberOfDays - 1);
    }
  }

  // ---------------------------------------------------------------------------

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorizontalPositioner &&
          runtimeType == other.runtimeType &&
          properties == other.properties &&
          widths == other.widths &&
          totalWidth == other.totalWidth;

  @override
  int get hashCode =>
      properties.hashCode ^ widths.hashCode ^ totalWidth.hashCode;

  double _minimumZero(double value) {
    if (value < 0.0) {
      return 0.0;
    } else {
      return value;
    }
  }

  @protected
  void throwArgumentErrorIfInvalidDayNumber(int dayNumber) {
    if (dayNumber < 0 || dayNumber >= properties.numberOfDays) {
      throw new ArgumentError.value(
        dayNumber,
        "dayNumber",
        "Invalid dayNumber",
      );
    }
  }

  @protected
  void throwArgumentErrorIfInvalidDaySeparationNumber(
    int daySeparationNumber,
  ) {
    if (properties.numberOfDaySeparations == 0) {
      throw new ArgumentError("There are no day separations (only one day)");
    } else {
      if (daySeparationNumber < 0 ||
          daySeparationNumber >= properties.numberOfDaySeparations) {
        throw new ArgumentError.value(
          daySeparationNumber,
          "daySeparationNumber",
          "invalid daySeparationNumber",
        );
      }
    }
  }
}

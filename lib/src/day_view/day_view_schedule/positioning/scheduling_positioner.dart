import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import 'package:calendar_views/src/day_view/day_view_essentials/day_view_area.dart';
import 'area.dart';

/// Object that assist in positioning components inside a [DayView].
@immutable
class Positioner extends HorizontalPositioner {
  Positioner({
    @required HorizontalPositioner horizontalPositioner,
    @required this.heightPerMinute,
    @required this.topExtensionHeight,
    @required this.bottomExtensionHeight,
  }) : super.fromHorizontalPositioner(horizontalPositioner);

  final double heightPerMinute;
  final double topExtensionHeight;
  final double bottomExtensionHeight;

  /// Height of the area that should be taken by some item that lasts [duration] number of minutes.
  double heightOfDuration(int duration) {
    return heightPerMinute * duration;
  }

  /// Location (from top) of a specific [minuteOfDay] inside DayView.
  double minuteOfDayFromTop(int minuteOfDay) {
    double r = topExtensionHeight;
    r += heightOfDuration(_minutesFromMinimumMinute(minuteOfDay));
    return r;
  }

  /// Returns the [Area] of some non-numbered-area.
  Area getArea(DayViewArea areaName) {
    switch (areaName) {
      case DayViewArea.contentArea:
        return nonPaddedArea;
      case DayViewArea.timeIndicationArea:
        return timeIndicationArea;
      case DayViewArea.separationArea:
        return separationArea;
      case DayViewArea.mainArea:
        return contentArea;
      case DayViewArea.eventArea:
        return eventArea;
      default:
        throw ArgumentError.value(
          areaName,
          "areaName",
          "$areaName is a numbered area, consider using \"getNumberedArea\"",
        );
    }
  }

  /// Returns the [Area] of some numbered-area
  Area getNumberedArea(DayViewArea areaName, int number) {
    switch (areaName) {
      case DayViewArea.dayArea:
        return dayArea(number);
      case DayViewArea.daySeparationArea:
        return daySeparationArea(number);
      default:
        throw new ArgumentError.value(
          areaName,
          "areaName",
          "$areaName is a non-numbered area, consider using \"getArea\"",
        );
    }
  }

  // NonPaddedArea -------------------------------------------------------------

  double get nonPaddedAreaHeight =>
      topExtensionHeight +
      heightOfDuration(properties.totalNumberOfMinutes) +
      bottomExtensionHeight;

  double get nonPaddedAreaTop => 0.0;

  double get nonPaddedAreaBottom => nonPaddedAreaTop + nonPaddedAreaHeight;

  Size get nonPaddedAreaSize => new Size(
        contentAreaWidth,
        nonPaddedAreaHeight,
      );

  Area get nonPaddedArea => new Area(
        name: DayViewArea.contentArea,
        size: nonPaddedAreaSize,
        left: contentAreaLeft,
        right: contentAreaRight,
        top: nonPaddedAreaTop,
        bottom: nonPaddedAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // TimeIndicationArea --------------------------------------------------------

  double get timeIndicationAreHeight => nonPaddedAreaHeight;

  double get timeIndicationAreaTop => 0.0;

  double get timeIndicationAreaBottom => nonPaddedAreaBottom;

  Size get timeIndicationAreaSize => new Size(
        timeIndicationAreaWidth,
        timeIndicationAreHeight,
      );

  Area get timeIndicationArea => new Area(
        name: DayViewArea.timeIndicationArea,
        size: timeIndicationAreaSize,
        left: timeIndicationAreaLeft,
        right: timeIndicationAreaRight,
        top: timeIndicationAreaTop,
        bottom: timeIndicationAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // SeparationArea ------------------------------------------------------------

  double get separationAreaHeight => nonPaddedAreaHeight;

  double get separationAreaTop => 0.0;

  double get separationAreaBottom => nonPaddedAreaBottom;

  Size get separationAreaSize => new Size(
        separationAreaWidth,
        separationAreaHeight,
      );

  Area get separationArea => new Area(
        name: DayViewArea.separationArea,
        size: separationAreaSize,
        left: separationAreaLeft,
        right: separationAreaRight,
        top: separationAreaTop,
        bottom: separationAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // ContentArea --------------------------------------------------------------

  double get contentAreaHeight => nonPaddedAreaHeight;

  double get contentAreaTop => 0.0;

  double get contentAreaBottom => nonPaddedAreaBottom;

  Size get contentAreaSize => new Size(
        mainAreaWidth,
        contentAreaHeight,
      );

  Area get contentArea => new Area(
        name: DayViewArea.mainArea,
        size: contentAreaSize,
        left: mainAreaLeft,
        right: mainAreaRight,
        top: contentAreaTop,
        bottom: contentAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // EventArea -----------------------------------------------------------------

  double get eventAreaHeight => nonPaddedAreaHeight;

  double get eventAreaTop => 0.0;

  double get eventAreaBottom => nonPaddedAreaBottom;

  Size get eventAreaSize => new Size(
        eventAreaWidth,
        eventAreaHeight,
      );

  Area get eventArea => new Area(
        name: DayViewArea.eventArea,
        size: eventAreaSize,
        left: eventAreaLeft,
        right: eventAreaRight,
        top: eventAreaTop,
        bottom: eventAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // DayArea -------------------------------------------------------------------

  double get dayAreaHeight => nonPaddedAreaHeight;

  double get dayAreaTop => 0.0;

  double get dayAreaBottom => nonPaddedAreaBottom;

  Size get dayAreaSize => new Size(
        dayAreaWidth(0),
        dayAreaHeight,
      );

  Area dayArea(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return new Area(
      name: DayViewArea.dayArea,
      size: dayAreaSize,
      left: dayAreaLeft(dayNumber),
      right: dayAreaRight(dayNumber),
      top: dayAreaTop,
      bottom: dayAreaBottom,
      minuteOfDayFromTop: minuteOfDayFromTop,
      heightOfDuration: heightOfDuration,
    );
  }

  // DaySeparationArea ---------------------------------------------------------

  double get daySeparationAreaHeight => nonPaddedAreaHeight;

  double get daySeparationAreaTop => 0.0;

  double get daySeparationAreaBottom => nonPaddedAreaBottom;

  Size get daySeparationAreaSize => new Size(
        daySeparationAreaWidth(0),
        daySeparationAreaHeight,
      );

  Area daySeparationArea(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return new Area(
      name: DayViewArea.daySeparationArea,
      size: daySeparationAreaSize,
      left: daySeparationAreaLeft(daySeparationNumber),
      right: daySeparationAreaRight(daySeparationNumber),
      top: daySeparationAreaTop,
      bottom: daySeparationAreaBottom,
      minuteOfDayFromTop: minuteOfDayFromTop,
      heightOfDuration: heightOfDuration,
    );
  }

  // ---------------------------------------------------------------------------

  /// Returns number of minutes between [minimumMinuteOfDay] and [minuteOfDay].
  int _minutesFromMinimumMinute(int minuteOfDay) {
    return minuteOfDay - properties.minimumMinuteOfDay;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Positioner &&
          runtimeType == other.runtimeType &&
          heightPerMinute == other.heightPerMinute &&
          topExtensionHeight == other.topExtensionHeight &&
          bottomExtensionHeight == other.bottomExtensionHeight;

  @override
  int get hashCode =>
      super.hashCode ^
      heightPerMinute.hashCode ^
      topExtensionHeight.hashCode ^
      bottomExtensionHeight.hashCode;
}

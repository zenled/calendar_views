import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import 'area_name.dart';
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
  Area getArea(AreaName areaName) {
    switch (areaName) {
      case AreaName.totalArea:
        return totalArea;
      case AreaName.timeIndicationArea:
        return timeIndicationArea;
      case AreaName.separationArea:
        return separationArea;
      case AreaName.contentArea:
        return contentArea;
      case AreaName.eventArea:
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
  Area getNumberedArea(AreaName areaName, int number) {
    switch (areaName) {
      case AreaName.dayArea:
        return dayArea(number);
      case AreaName.daySeparationArea:
        return daySeparationArea(number);
      default:
        throw new ArgumentError.value(
          areaName,
          "areaName",
          "$areaName is a non-numbered area, consider using \"getArea\"",
        );
    }
  }

  // TotalArea -----------------------------------------------------------------

  double get totalAreaHeight =>
      topExtensionHeight +
      heightOfDuration(properties.totalNumberOfMinutes) +
      bottomExtensionHeight;

  double get totalAreaTop => 0.0;

  double get totalAreaBottom => totalAreaTop + totalAreaHeight;

  Size get totalAreaSize => new Size(
        totalAreaWidth,
        totalAreaHeight,
      );

  Area get totalArea => new Area(
        name: AreaName.totalArea,
        size: totalAreaSize,
        left: totalAreaLeft,
        right: totalAreaRight,
        top: totalAreaTop,
        bottom: totalAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // TimeIndicationArea --------------------------------------------------------

  double get timeIndicationAreHeight => totalAreaHeight;

  double get timeIndicationAreaTop => 0.0;

  double get timeIndicationAreaBottom => totalAreaBottom;

  Size get timeIndicationAreaSize => new Size(
        timeIndicationAreaWidth,
        timeIndicationAreHeight,
      );

  Area get timeIndicationArea => new Area(
        name: AreaName.timeIndicationArea,
        size: timeIndicationAreaSize,
        left: timeIndicationAreaLeft,
        right: timeIndicationAreaRight,
        top: timeIndicationAreaTop,
        bottom: timeIndicationAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // SeparationArea ------------------------------------------------------------

  double get separationAreaHeight => totalAreaHeight;

  double get separationAreaTop => 0.0;

  double get separationAreaBottom => totalAreaBottom;

  Size get separationAreaSize => new Size(
        separationAreaWidth,
        separationAreaHeight,
      );

  Area get separationArea => new Area(
        name: AreaName.separationArea,
        size: separationAreaSize,
        left: separationAreaLeft,
        right: separationAreaRight,
        top: separationAreaTop,
        bottom: separationAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // ContentArea --------------------------------------------------------------

  double get contentAreaHeight => totalAreaHeight;

  double get contentAreaTop => 0.0;

  double get contentAreaBottom => totalAreaBottom;

  Size get contentAreaSize => new Size(
        contentAreaWidth,
        contentAreaHeight,
      );

  Area get contentArea => new Area(
        name: AreaName.contentArea,
        size: contentAreaSize,
        left: contentAreaLeft,
        right: contentAreaRight,
        top: contentAreaTop,
        bottom: contentAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // EventArea -----------------------------------------------------------------

  double get eventAreaHeight => totalAreaHeight;

  double get eventAreaTop => 0.0;

  double get eventAreaBottom => totalAreaBottom;

  Size get eventAreaSize => new Size(
        eventAreaWidth,
        eventAreaHeight,
      );

  Area get eventArea => new Area(
        name: AreaName.eventArea,
        size: eventAreaSize,
        left: eventAreaLeft,
        right: eventAreaRight,
        top: eventAreaTop,
        bottom: eventAreaBottom,
        minuteOfDayFromTop: minuteOfDayFromTop,
        heightOfDuration: heightOfDuration,
      );

  // DayArea -------------------------------------------------------------------

  double get dayAreaHeight => totalAreaHeight;

  double get dayAreaTop => 0.0;

  double get dayAreaBottom => totalAreaBottom;

  Size get dayAreaSize => new Size(
        dayAreaWidth,
        dayAreaHeight,
      );

  Area dayArea(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return new Area(
      name: AreaName.dayArea,
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

  double get daySeparationAreaHeight => totalAreaHeight;

  double get daySeparationAreaTop => 0.0;

  double get daySeparationAreaBottom => totalAreaBottom;

  Size get daySeparationAreaSize => new Size(
        daySeparationAreaWidth,
        daySeparationAreaHeight,
      );

  Area daySeparationArea(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return new Area(
      name: AreaName.daySeparationArea,
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

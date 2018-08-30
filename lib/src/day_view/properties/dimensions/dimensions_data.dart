import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/day_view_OLD.dart';

/// Data about sizes inside a [DayViewOLD].
@immutable
class DimensionsData {
  const DimensionsData({
    this.heightPerMinute = 1.0,
    this.daySeparationWidth = 20.0,
    this.topExtensionHeight = 40.0,
    this.bottomExtensionHeight = 40.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.eventsAreaStartMargin = 8.0,
    this.eventsAreaEndMargin = 8.0,
  })  : assert(heightPerMinute != null && heightPerMinute > 0),
        assert(daySeparationWidth != null && daySeparationWidth >= 0),
        assert(topExtensionHeight != null && topExtensionHeight >= 0),
        assert(bottomExtensionHeight != null && bottomExtensionHeight >= 0),
        assert(timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0),
        assert(eventsAreaStartMargin != null && eventsAreaStartMargin >= 0),
        assert(eventsAreaEndMargin != null && eventsAreaEndMargin >= 0);

  /// Height taken by a minute in a [DayViewOLD].
  final double heightPerMinute;

  /// Width of separation between days in a [DayViewOLD].
  final double daySeparationWidth;

  // extension

  /// Height of extension at the top of [DayViewOLD].
  final double topExtensionHeight;

  /// Height of extension at the bottom of [DayViewOLD]
  final double bottomExtensionHeight;

  // areas from start to end

  /// Width of TimeIndicationArea.
  final double timeIndicationAreaWidth;

  /// Width of SeparationArea.
  final double separationAreaWidth;

  /// Width of margin at start (left) of EventsArea.
  final double eventsAreaStartMargin;

  /// Width of margin at end (right) of EventsArea.
  final double eventsAreaEndMargin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DimensionsData &&
          runtimeType == other.runtimeType &&
          heightPerMinute == other.heightPerMinute &&
          daySeparationWidth == other.daySeparationWidth &&
          topExtensionHeight == other.topExtensionHeight &&
          bottomExtensionHeight == other.bottomExtensionHeight &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          eventsAreaStartMargin == other.eventsAreaStartMargin &&
          eventsAreaEndMargin == other.eventsAreaEndMargin;

  @override
  int get hashCode =>
      heightPerMinute.hashCode ^
      daySeparationWidth.hashCode ^
      topExtensionHeight.hashCode ^
      bottomExtensionHeight.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      eventsAreaStartMargin.hashCode ^
      eventsAreaEndMargin.hashCode;
}

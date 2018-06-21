import 'package:meta/meta.dart';

@immutable
class DayViewDimensions {
  const DayViewDimensions({
    @required this.width,
    this.heightPerMinute = 1.0,
    this.paddingStart = 16.0,
    this.paddingEnd = 16.0,
    this.paddingTop = 40.0,
    this.paddingBottom = 40.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.eventsAreaStartMargin = 8.0,
    this.eventsAreaEndMargin = 8.0,
  })  : assert(width != null && width > 0),
        assert(heightPerMinute != null && heightPerMinute > 0),
        assert(paddingStart != null && paddingStart >= 0),
        assert(paddingEnd != null && paddingEnd >= 0),
        assert(paddingTop != null && paddingTop >= 0),
        assert(paddingBottom != null && paddingBottom >= 0),
        assert(timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0),
        assert(eventsAreaStartMargin != null && eventsAreaStartMargin >= 0),
        assert(eventsAreaEndMargin != null && eventsAreaEndMargin >= 0);

  // size
  /// Width of DayView.
  final double width;

  /// Height taken by every minute in DayView.
  final double heightPerMinute;

  // padding

  /// Padding at the start (left) of DayView.
  final double paddingStart;

  /// Padding at the end (right) of DayView.
  final double paddingEnd;

  /// Padding at the top of DayView.
  final double paddingTop;

  /// Padding at the bottom of DayView
  final double paddingBottom;

  // areas from start to end

  /// Width of timeIndicationArea.
  final double timeIndicationAreaWidth;

  /// Width of separation between the end of [timeIndicationAreaWidth] and start of [eventsAreaStartMargin].
  final double separationAreaWidth;

  /// Width of margin at start of EventsArea.
  final double eventsAreaStartMargin;

  /// Width of eventsArea.
  double get eventsAreaWidth =>
      width -
      paddingStart -
      timeIndicationAreaWidth -
      separationAreaWidth -
      eventsAreaStartMargin -
      eventsAreaEndMargin -
      paddingEnd;

  /// Width of margin at end of EventsArea.
  final double eventsAreaEndMargin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayViewDimensions &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          heightPerMinute == other.heightPerMinute &&
          paddingStart == other.paddingStart &&
          paddingEnd == other.paddingEnd &&
          paddingTop == other.paddingTop &&
          paddingBottom == other.paddingBottom &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          eventsAreaStartMargin == other.eventsAreaStartMargin &&
          eventsAreaEndMargin == other.eventsAreaEndMargin;

  @override
  int get hashCode =>
      width.hashCode ^
      heightPerMinute.hashCode ^
      paddingStart.hashCode ^
      paddingEnd.hashCode ^
      paddingTop.hashCode ^
      paddingBottom.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      eventsAreaStartMargin.hashCode ^
      eventsAreaEndMargin.hashCode;
}

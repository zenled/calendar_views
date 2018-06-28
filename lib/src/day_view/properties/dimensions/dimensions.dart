import 'package:meta/meta.dart';

/// Sizes of key DayView components.
@immutable
class Dimensions {
  const Dimensions({
    this.heightPerMinute = 1.0,
    this.separationBetweenDays = 20.0,
    this.topExtension = 40.0,
    this.bottomExtension = 40.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.eventsAreaStartMargin = 8.0,
    this.eventsAreaEndMargin = 8.0,
  })  : assert(heightPerMinute != null && heightPerMinute > 0),
        assert(separationBetweenDays != null && separationBetweenDays >= 0),
        assert(topExtension != null && topExtension >= 0),
        assert(bottomExtension != null && bottomExtension >= 0),
        assert(timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0),
        assert(eventsAreaStartMargin != null && eventsAreaStartMargin >= 0),
        assert(eventsAreaEndMargin != null && eventsAreaEndMargin >= 0);

  /// Height taken by every minute inside a DayView.
  final double heightPerMinute;

  /// Separation between days of DayView.
  final double separationBetweenDays;

  // extension

  /// Extension at the top of DayView.
  final double topExtension;

  /// Extension at the bottom of DayView
  final double bottomExtension;

  // areas from start to end

  /// Width of TimeIndicationArea.
  final double timeIndicationAreaWidth;

  /// Width of SeparationArea.
  ///
  /// SeparationArea is area between the end of TimeIndicationArea and start of ContentArea.
  final double separationAreaWidth;

  /// Width of margin at start (left) of EventsArea.
  final double eventsAreaStartMargin;

  /// Width of margin at end (right) of EventsArea.
  final double eventsAreaEndMargin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dimensions &&
          runtimeType == other.runtimeType &&
          heightPerMinute == other.heightPerMinute &&
          separationBetweenDays == other.separationBetweenDays &&
          topExtension == other.topExtension &&
          bottomExtension == other.bottomExtension &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          eventsAreaStartMargin == other.eventsAreaStartMargin &&
          eventsAreaEndMargin == other.eventsAreaEndMargin;

  @override
  int get hashCode =>
      heightPerMinute.hashCode ^
      separationBetweenDays.hashCode ^
      topExtension.hashCode ^
      bottomExtension.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      eventsAreaStartMargin.hashCode ^
      eventsAreaEndMargin.hashCode;
}

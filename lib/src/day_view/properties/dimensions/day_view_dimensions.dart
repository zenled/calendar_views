part of day_view_dimensions;

/// Sizes of key DayView components.
@immutable
class DayViewDimensions {
  const DayViewDimensions({
    this.heightPerMinute = 1.0,
    this.separationBetweenDays = 20.0,
    this.paddingTop = 40.0,
    this.paddingBottom = 40.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.eventsAreaStartMargin = 8.0,
    this.eventsAreaEndMargin = 8.0,
  })  : assert(heightPerMinute != null && heightPerMinute > 0),
        assert(separationBetweenDays != null && separationBetweenDays >= 0),
        assert(paddingTop != null && paddingTop >= 0),
        assert(paddingBottom != null && paddingBottom >= 0),
        assert(timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0),
        assert(eventsAreaStartMargin != null && eventsAreaStartMargin >= 0),
        assert(eventsAreaEndMargin != null && eventsAreaEndMargin >= 0);

  /// Height taken by every minute inside a DayView.
  final double heightPerMinute;

  /// Separation between days of DayView.
  final double separationBetweenDays;

  // padding

  /// Padding at the top of DayView.
  final double paddingTop;

  /// Padding at the bottom of DayView
  final double paddingBottom;

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
      other is DayViewDimensions &&
          runtimeType == other.runtimeType &&
          heightPerMinute == other.heightPerMinute &&
          separationBetweenDays == other.separationBetweenDays &&
          paddingTop == other.paddingTop &&
          paddingBottom == other.paddingBottom &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          eventsAreaStartMargin == other.eventsAreaStartMargin &&
          eventsAreaEndMargin == other.eventsAreaEndMargin;

  @override
  int get hashCode =>
      heightPerMinute.hashCode ^
      separationBetweenDays.hashCode ^
      paddingTop.hashCode ^
      paddingBottom.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      eventsAreaStartMargin.hashCode ^
      eventsAreaEndMargin.hashCode;
}

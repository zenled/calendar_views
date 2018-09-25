import 'package:meta/meta.dart';

/// Class that contains information about widths for day-view widgets.
@immutable
class DayViewWidths {
  const DayViewWidths({
    this.totalAreaStartMargin = 8.0,
    this.totalAreaEndMargin = 8.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.mainAreaStartMargin = 8.0,
    this.mainAreaEndMargin = 8.0,
    this.daySeparationAreaWidth = 20.0,
  })  : assert(totalAreaStartMargin != null && totalAreaStartMargin >= 0),
        assert(totalAreaEndMargin != null && totalAreaEndMargin >= 0),
        assert(
            timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0.0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0.0),
        assert(mainAreaStartMargin != null && mainAreaStartMargin >= 0.0),
        assert(mainAreaEndMargin != null && mainAreaEndMargin >= 0.0),
        assert(daySeparationAreaWidth != null && daySeparationAreaWidth >= 0.0);

  final double totalAreaStartMargin;
  final double totalAreaEndMargin;

  final double timeIndicationAreaWidth;

  final double separationAreaWidth;

  final double mainAreaStartMargin;
  final double mainAreaEndMargin;

  final double daySeparationAreaWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayViewWidths &&
          runtimeType == other.runtimeType &&
          totalAreaStartMargin == other.totalAreaStartMargin &&
          totalAreaEndMargin == other.totalAreaEndMargin &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          mainAreaStartMargin == other.mainAreaStartMargin &&
          mainAreaEndMargin == other.mainAreaEndMargin &&
          daySeparationAreaWidth == other.daySeparationAreaWidth;

  @override
  int get hashCode =>
      totalAreaStartMargin.hashCode ^
      totalAreaEndMargin.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      mainAreaStartMargin.hashCode ^
      mainAreaEndMargin.hashCode ^
      daySeparationAreaWidth.hashCode;
}

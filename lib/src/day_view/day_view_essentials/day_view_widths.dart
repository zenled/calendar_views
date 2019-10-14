import 'package:meta/meta.dart';

/// Class that contains information about widths for day view widgets.
@immutable
class DayViewWidths {
  const DayViewWidths({
    this.totalAreaStartPadding = 8.0,
    this.totalAreaEndPadding = 8.0,
    this.timeIndicationAreaWidth = 0.0,
    this.separationAreaWidth = 4.0,
    this.mainAreaStartPadding = 0.0,
    this.mainAreaEndPadding = 4.0,
    this.daySeparationAreaWidth = 1.0,
  })  : assert(totalAreaStartPadding != null && totalAreaStartPadding >= 0),
        assert(totalAreaEndPadding != null && totalAreaEndPadding >= 0),
        assert(
            timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0.0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0.0),
        assert(mainAreaStartPadding != null && mainAreaStartPadding >= 0.0),
        assert(mainAreaEndPadding != null && mainAreaEndPadding >= 0.0),
        assert(daySeparationAreaWidth != null && daySeparationAreaWidth >= 0.0);

  final double totalAreaStartPadding;
  final double totalAreaEndPadding;

  final double timeIndicationAreaWidth;

  final double separationAreaWidth;

  final double mainAreaStartPadding;
  final double mainAreaEndPadding;

  final double daySeparationAreaWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayViewWidths &&
          runtimeType == other.runtimeType &&
          totalAreaStartPadding == other.totalAreaStartPadding &&
          totalAreaEndPadding == other.totalAreaEndPadding &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          mainAreaStartPadding == other.mainAreaStartPadding &&
          mainAreaEndPadding == other.mainAreaEndPadding &&
          daySeparationAreaWidth == other.daySeparationAreaWidth;

  @override
  int get hashCode =>
      totalAreaStartPadding.hashCode ^
      totalAreaEndPadding.hashCode ^
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      mainAreaStartPadding.hashCode ^
      mainAreaEndPadding.hashCode ^
      daySeparationAreaWidth.hashCode;
}

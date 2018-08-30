import 'package:meta/meta.dart';

@immutable
class Widths {
  const Widths({
    this.paddingStart = 0.0,
    this.paddingEnd = 0.0,
    this.timeIndicationAreaWidth = 60.0,
    this.separationAreaWidth = 4.0,
    this.eventAreaStartMargin = 8.0,
    this.eventAreaEndMargin = 8.0,
    this.daySeparationWidth = 20.0,
  })  : assert(paddingStart != null && paddingStart >= 0),
        assert(paddingEnd != null && paddingEnd >= 0),
        assert(
            timeIndicationAreaWidth != null && timeIndicationAreaWidth >= 0.0),
        assert(separationAreaWidth != null && separationAreaWidth >= 0.0),
        assert(eventAreaStartMargin != null && eventAreaStartMargin >= 0.0),
        assert(eventAreaEndMargin != null && eventAreaEndMargin >= 0.0),
        assert(daySeparationWidth != null && daySeparationWidth >= 0.0);

  final double paddingStart;
  final double paddingEnd;

  final double timeIndicationAreaWidth;
  final double separationAreaWidth;
  final double eventAreaStartMargin;
  final double eventAreaEndMargin;
  final double daySeparationWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Widths &&
          runtimeType == other.runtimeType &&
          timeIndicationAreaWidth == other.timeIndicationAreaWidth &&
          separationAreaWidth == other.separationAreaWidth &&
          eventAreaStartMargin == other.eventAreaStartMargin &&
          eventAreaEndMargin == other.eventAreaEndMargin &&
          daySeparationWidth == other.daySeparationWidth;

  @override
  int get hashCode =>
      timeIndicationAreaWidth.hashCode ^
      separationAreaWidth.hashCode ^
      eventAreaStartMargin.hashCode ^
      eventAreaEndMargin.hashCode ^
      daySeparationWidth.hashCode;
}

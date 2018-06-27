import 'package:meta/meta.dart';

typedef double ArrangerConstraintsPositionTopOfCallback(int minuteOfDay);

typedef double ArrangerConstraintsHeightOfCallback(int durationInMinutes);

@immutable
class ArrangerConstraints {
  ArrangerConstraints({
    @required this.areaWidth,
    @required this.areaHeight,
    @required this.positionTopOf,
    @required this.heightOf,
  })  : assert(areaWidth != null && areaWidth >= 0),
        assert(areaHeight != null && areaHeight >= 0),
        assert(positionTopOf != null),
        assert(heightOf != null);

  /// Size of the area in which to arrange events.
  final double areaWidth;

  final double areaHeight;

  /// Callback thar returns a position of some minute of day from top.
  final ArrangerConstraintsPositionTopOfCallback positionTopOf;

  /// Callback that returns the recommended height of some item, depending on the item duration.
  final ArrangerConstraintsHeightOfCallback heightOf;
}

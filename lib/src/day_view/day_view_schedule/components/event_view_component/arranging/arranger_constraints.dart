import 'package:meta/meta.dart';

/// Signature for a function that returns the position (from top) of some minute of day.
typedef double ArrangerConstraintsPositionOfMinuteFromTopCallback(
  int minuteOfDay,
);

/// Signature for a function that returns a height of some duration of minutes.
typedef double ArrangerConstraintsHeightOfDurationCallback(
  int durationInMinutes,
);

/// Constraints passed to [EventsArranger].
@immutable
class ArrangerConstraints {
  ArrangerConstraints({
    @required this.areaWidth,
    @required this.areaHeight,
    @required this.positionOfMinuteFromTop,
    @required this.heightOfDuration,
  })  : assert(areaWidth != null && areaWidth >= 0),
        assert(areaHeight != null && areaHeight >= 0),
        assert(positionOfMinuteFromTop != null),
        assert(heightOfDuration != null);

  /// Width of the area inside of which events should be arranged.
  final double areaWidth;

  /// Height of the area inside of which events should be arranged.
  final double areaHeight;

  /// Callback thar returns a position of some minute of day from top.
  final ArrangerConstraintsPositionOfMinuteFromTopCallback
      positionOfMinuteFromTop;

  /// Callback that returns the recommended height of some item, depending on its duration.
  final ArrangerConstraintsHeightOfDurationCallback heightOfDuration;
}

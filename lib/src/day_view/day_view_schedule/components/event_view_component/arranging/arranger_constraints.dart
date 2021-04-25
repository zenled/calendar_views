import 'package:calendar_views/day_view.dart';
import 'package:meta/meta.dart';

/// Constraints passed to [EventViewArranger].
@immutable
class ArrangerConstraints {
  ArrangerConstraints({
    required this.areaWidth,
    required this.areaHeight,
    required this.minuteOfDayFromTop,
    required this.heightOfDuration,
  })   : assert(areaWidth >= 0),
        assert(areaHeight >= 0);

  /// Width of the area inside of which events should be arranged.
  final double areaWidth;

  /// Height of the area inside of which events should be arranged.
  final double areaHeight;

  /// Callback thar returns the distance from top of some minute of day.
  final MinuteOfDayFromTopCallback minuteOfDayFromTop;

  /// Callback that returns the height of some item, given its duration.
  final HeightOfDurationCallback heightOfDuration;
}

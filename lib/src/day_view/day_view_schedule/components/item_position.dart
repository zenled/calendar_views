import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Recommendation for position of an item inside a [DayViewSchedule].
@immutable
class ItemPosition {
  const ItemPosition({
    @required this.top,
    @required this.left,
  })  : assert(top != null),
        assert(left != null);

  /// Position from top edge of [DayViewSchedule].
  final double top;

  /// Position from left edge of [DayViewSchedule].
  final double left;
}

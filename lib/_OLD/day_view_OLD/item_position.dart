import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/_OLD/day_view_OLD.dart';

/// Guideline position that an item inside a [DayViewOLD] should take.
@immutable
class ItemPosition {
  const ItemPosition({
    @required this.top,
    @required this.left,
  })  : assert(top != null),
        assert(left != null);

  /// Position of item from top.
  final double top;

  /// Position of item from left.
  final double left;
}

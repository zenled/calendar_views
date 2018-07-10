import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/day_view.dart';

/// Guideline position that an item inside a [DayView] should take.
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

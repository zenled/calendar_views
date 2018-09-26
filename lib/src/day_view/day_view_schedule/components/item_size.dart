import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Recommendation for size of an item inside a [DayViewSchedule].
@immutable
class ItemSize {
  ItemSize({
    @required this.width,
    @required this.height,
  })  : assert(width != null && width >= 0),
        assert(height != null && height >= 0);

  /// Width recommendation for item.
  final double width;

  /// Height recommendation for item.
  final double height;
}

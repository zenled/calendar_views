import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Guideline size that an item inside a [DayView] should take.
@immutable
class ItemSize {
  ItemSize({
    @required this.width,
    @required this.height,
  })  : assert(width != null && width >= 0),
        assert(height != null && height >= 0);

  /// Width of the item.
  final double width;

  /// Height of the item.
  final double height;
}

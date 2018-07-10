import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/day_view.dart';

/// Size constraints placed upon a [DayView].
@immutable
class SizeConstraintsData {
  const SizeConstraintsData({
    @required this.availableWidth,
  }) : assert(availableWidth != null && availableWidth > 0);

  /// Maximum with that a [DayView] is allowed and should occupy.
  final double availableWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeConstraintsData &&
          runtimeType == other.runtimeType &&
          availableWidth == other.availableWidth;

  @override
  int get hashCode => availableWidth.hashCode;

  @override
  String toString() {
    return 'SizeConstraints{availableWidth: $availableWidth}';
  }
}

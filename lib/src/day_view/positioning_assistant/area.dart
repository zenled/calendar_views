import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/day_view.dart';

import 'area_name.dart';

/// Signature for a function that returns position of minute of day from top inside of an area.
typedef double MinuteOfDayFromTopInsideArea(int minuteOfDay);

/// Signature for a function that returns height of some number of minutes inside of an area.
typedef double HeightOfDurationInsideArea(int duration);

/// Class with data about area that belongs to a [DayView].
@immutable
class Area {
  const Area({
    @required this.name,
    @required this.size,
    @required this.left,
    @required this.right,
    @required this.top,
    @required this.bottom,
    @required this.minuteOfDayFromTop,
    @required this.heightOfDuration,
  })  : assert(name != null),
        assert(size != null),
        assert(left != null),
        assert(right != null),
        assert(top != null),
        assert(bottom != null),
        assert(minuteOfDayFromTop != null),
        assert(heightOfDuration != null);

  final AreaName name;

  final Size size;

  final double left;

  final double right;

  final double top;

  final double bottom;

  final MinuteOfDayFromTopInsideArea minuteOfDayFromTop;

  final HeightOfDurationInsideArea heightOfDuration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Area &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          size == other.size &&
          left == other.left &&
          right == other.right &&
          top == other.top &&
          bottom == other.bottom;

  @override
  int get hashCode =>
      name.hashCode ^
      size.hashCode ^
      left.hashCode ^
      right.hashCode ^
      top.hashCode ^
      bottom.hashCode;

  @override
  String toString() {
    return 'Area{name: $name, size: $size, l: $left, r: $right, t: $top, b: $bottom}';
  }
}

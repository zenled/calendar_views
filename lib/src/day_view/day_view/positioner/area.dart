import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

typedef double MinuteOfDayFromTopCallback(int minuteOfDay);

typedef double HeightOfDurationCallback(int duration);

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

  final MinuteOfDayFromTopCallback minuteOfDayFromTop;

  final HeightOfDurationCallback heightOfDuration;
}

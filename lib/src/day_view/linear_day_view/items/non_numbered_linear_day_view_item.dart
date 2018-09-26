import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class NonNumberedLinearDayViewItem implements LinearDayViewItem {
  NonNumberedLinearDayViewItem({
    @required this.area,
    @required this.itemBuilder,
  })  : assert(area != null && isNonNumberedDayViewArea(area)),
        assert(itemBuilder != null);

  final DayViewArea area;

  final WidgetBuilder itemBuilder;
}

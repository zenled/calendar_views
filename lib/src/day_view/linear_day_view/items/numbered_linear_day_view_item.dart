import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class NumberedLinearDayViewItem implements LinearDayViewItem {
  NumberedLinearDayViewItem({
    @required this.area,
    @required this.areNumber,
    @required this.itemBuilder,
  })  : assert(area != null && isNumberedDayViewArea(area)),
        assert(areNumber != null),
        assert(itemBuilder != null);

  final DayViewArea area;
  final int areNumber;

  final WidgetBuilder itemBuilder;
}

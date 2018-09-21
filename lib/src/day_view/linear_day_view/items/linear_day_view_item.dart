import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
abstract class LinearDayViewItem {
  DayViewArea get area;

  WidgetBuilder get itemBuilder;
}

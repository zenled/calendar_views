import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

abstract class DayViewComponent {
  const DayViewComponent();

  List<Positioned> buildItems({
    @required BuildContext context,
    @required DayViewProperties properties,
    @required Positioner positioner,
  });
}

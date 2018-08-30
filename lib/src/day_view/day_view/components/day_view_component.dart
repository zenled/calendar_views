import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
abstract class DayViewComponent {
  const DayViewComponent();

  List<Positioned> buildItems({
    @required BuildContext context,
    @required Properties properties,
    @required Positioner positioner,
  });
}

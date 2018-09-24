import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Base class for a component whose items will be displayed as children of [DayViewSchedule].
abstract class ScheduleComponent {
  const ScheduleComponent();

  /// Builds a list of [Positioned] widget that will be displayed as children of [DayViewSchedule].
  List<Positioned> buildItems({
    @required BuildContext context,
    @required DayViewProperties properties,
    @required SchedulePositioner positioner,
  });
}

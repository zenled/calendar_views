import 'package:flutter/material.dart';

import 'package:calendar_views/day_view.dart';

/// Base class for a component whose built items will be displayed as children of [DayViewSchedule].
abstract class ScheduleComponent {
  const ScheduleComponent();

  /// Builds a list of [Positioned] widget that will be displayed as children of [DayViewSchedule].
  List<Positioned> buildItems(
    BuildContext context,
    DayViewProperties properties,
    SchedulePositioner positioner,
  );
}

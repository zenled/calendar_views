import 'package:flutter/material.dart';

import 'package:calendar_views/src/day_view/day_view_OLD.dart';

/// Base for a class that builds items that will be displayed inside a [DayViewOLD].
@immutable
abstract class Component {
  const Component();

  /// Returns Items that will be displayed inside a [DayViewOLD].
  ///
  /// Every item should be encapsulated in a [Positioned] widget so that [DayViewOLD]
  /// knows how where to display them.
  List<Positioned> buildItems(BuildContext context);
}

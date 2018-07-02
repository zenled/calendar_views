import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days.dart';

/// Widget that propagates DayView dates down the tree.
class DaysProvider extends InheritedWidget {
  const DaysProvider({
    @required this.days,
    @required Widget child,
  })  : assert(days != null),
        super(child: child);

  final Days days;

  @override
  bool updateShouldNotify(DaysProvider oldWidget) {
    return days != oldWidget.days;
  }

  static Days of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DaysProvider) as DaysProvider)
        .days;
  }
}

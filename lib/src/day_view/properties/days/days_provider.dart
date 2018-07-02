import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days.dart';

/// Widget that propagates DayView dates down the tree.
class DaysProvider extends InheritedWidget {
  const DaysProvider({
    @required this.dates,
    @required Widget child,
  })  : assert(dates != null),
        super(child: child);

  final Days dates;

  @override
  bool updateShouldNotify(DaysProvider oldWidget) {
    return dates != oldWidget.dates;
  }

  static Days of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DaysProvider) as DaysProvider)
        .dates;
  }
}

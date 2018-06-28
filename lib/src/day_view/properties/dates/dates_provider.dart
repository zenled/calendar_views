import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'dates.dart';

/// Widget that propagates DayView dates down the tree.
class DatesProvider extends InheritedWidget {
  const DatesProvider({
    @required this.dates,
    @required Widget child,
  })  : assert(dates != null),
        super(child: child);

  final Dates dates;

  @override
  bool updateShouldNotify(DatesProvider oldWidget) {
    return dates != oldWidget.dates;
  }

  static Dates of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DatesProvider)
            as DatesProvider)
        .dates;
  }
}

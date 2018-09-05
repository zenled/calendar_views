import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days_data.dart';

/// Widget that propagates [DaysOLD].
class DaysOLD extends InheritedWidget {
  const DaysOLD({
    @required this.daysData,
    @required Widget child,
  })  : assert(daysData != null),
        super(child: child);

  final DaysData daysData;

  @override
  bool updateShouldNotify(DaysOLD oldWidget) {
    return daysData != oldWidget.daysData;
  }

  static DaysData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DaysOLD) as DaysOLD).daysData;
  }
}

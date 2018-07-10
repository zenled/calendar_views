import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days_data.dart';

/// Widget that propagates [Days].
class Days extends InheritedWidget {
  const Days({
    @required this.daysData,
    @required Widget child,
  })  : assert(daysData != null),
        super(child: child);

  final DaysData daysData;

  @override
  bool updateShouldNotify(Days oldWidget) {
    return daysData != oldWidget.daysData;
  }

  static DaysData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Days) as Days).daysData;
  }
}

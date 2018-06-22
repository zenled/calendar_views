import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DayViewDate extends InheritedWidget {
  const DayViewDate({
    @required this.date,
    @required Widget child,
  })  : assert(date != null),
        super(child: child);

  final DateTime date;

  @override
  bool updateShouldNotify(DayViewDate oldWidget) {
    return oldWidget.date.year != date.year ||
        oldWidget.date.month != date.month ||
        oldWidget.date.day != date.day;
  }

  static DayViewDate of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewDate);
  }
}

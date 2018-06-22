import 'package:flutter/material.dart';

class DayViewRestrictions extends InheritedWidget {
  DayViewRestrictions({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required Widget child,
  })  : assert(minimumMinuteOfDay != null),
        assert(maximumMinuteOfDay != null),
        super(child: child);

  final int minimumMinuteOfDay;

  final int maximumMinuteOfDay;

  @override
  bool updateShouldNotify(DayViewRestrictions oldWidget) {
    return oldWidget.minimumMinuteOfDay != minimumMinuteOfDay ||
        oldWidget.maximumMinuteOfDay != maximumMinuteOfDay;
  }

  static DayViewRestrictions of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewRestrictions);
  }
}

import 'package:flutter/material.dart';

import 'package:calendar_views/src/utils/all.dart';

/// Widget that propagates restrictions placed upon DayViews.
class DayViewRestrictions extends InheritedWidget {
  DayViewRestrictions({
    @required this.minimumMinuteOfDay,
    @required this.maximumMinuteOfDay,
    @required Widget child,
  })  : assert(minimumMinuteOfDay != null &&
            isValidMinuteOfDay(minimumMinuteOfDay)),
        assert(maximumMinuteOfDay != null &&
            isValidMinuteOfDay(maximumMinuteOfDay)),
        assert(maximumMinuteOfDay >= minimumMinuteOfDay),
        super(child: child);

  /// Minimum minuteOfDay that child DayViews are allowed to display (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minuteOfDay that child DayViews are allowed to display (inclusive).
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

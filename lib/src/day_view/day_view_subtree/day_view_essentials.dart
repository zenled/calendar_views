import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayViewEssentials extends InheritedWidget {
  DayViewEssentials({
    @required this.properties,
    @required this.horizontalPositioner,
    @required Widget child,
  })  : assert(properties != null),
        assert(horizontalPositioner != null),
        super(child: child);

  final Properties properties;
  final HorizontalPositioner horizontalPositioner;

  @override
  bool updateShouldNotify(DayViewEssentials oldWidget) {
    return properties != oldWidget.properties ||
        horizontalPositioner != oldWidget.horizontalPositioner;
  }

  static DayViewEssentials of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewEssentials);
  }
}

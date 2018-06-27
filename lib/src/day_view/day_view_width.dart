import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DayViewWidth extends InheritedWidget {
  DayViewWidth({
    @required this.width,
    @required Widget child,
  })  : assert(width != null && width >= 0),
        super(child: child);

  final double width;

  @override
  bool updateShouldNotify(DayViewWidth oldWidget) {
    return oldWidget.width != width;
  }

  static DayViewWidth of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewWidth);
  }
}

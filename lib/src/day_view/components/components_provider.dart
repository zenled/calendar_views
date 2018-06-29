import 'package:flutter/material.dart';

import 'day_view_component.dart';

/// Inherited widget that provides list of [DayViewComponent]s to its children.
class DayViewComponentsProvider extends InheritedWidget {
  DayViewComponentsProvider({
    @required this.components,
    @required Widget child,
  })  : assert(components != null),
        super(child: child);

  /// List of components to be displayed by DayView.
  final List<DayViewComponent> components;

  @override
  bool updateShouldNotify(DayViewComponentsProvider oldWidget) {
    return oldWidget.components != components;
  }

  static DayViewComponentsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewComponentsProvider);
  }
}

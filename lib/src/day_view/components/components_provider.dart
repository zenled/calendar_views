import 'package:flutter/material.dart';

import 'component.dart';

/// Inherited widget that provides list of [Component]s to its children.
class ComponentsProvider extends InheritedWidget {
  ComponentsProvider({
    @required this.components,
    @required Widget child,
  })  : assert(components != null),
        super(child: child);

  /// List of components to be displayed by DayView.
  final List<Component> components;

  @override
  bool updateShouldNotify(ComponentsProvider oldWidget) {
    return components != oldWidget.components;
  }

  static List<Component> of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ComponentsProvider)
            as ComponentsProvider)
        .components;
  }
}

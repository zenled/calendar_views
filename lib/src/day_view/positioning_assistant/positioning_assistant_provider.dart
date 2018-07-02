import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'positioning_assistant.dart';

class PositioningAssistantProvider extends InheritedWidget {
  PositioningAssistantProvider({
    @required this.positioningAssistant,
    @required Widget child,
  })  : assert(positioningAssistant != null),
        super(child: child);

  final PositioningAssistant positioningAssistant;

  @override
  bool updateShouldNotify(PositioningAssistantProvider oldWidget) {
    return positioningAssistant != oldWidget.positioningAssistant;
  }

  static PositioningAssistant of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PositioningAssistantProvider)
            as PositioningAssistantProvider)
        .positioningAssistant;
  }
}

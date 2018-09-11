import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event_management.dart';

class EventManagement extends InheritedWidget {
  EventManagement({
    @required this.eventManagementData,
    @required Widget child,
  })  : assert(eventManagementData != null),
        super(child: child);

  final EventManager eventManagementData;

  @override
  bool updateShouldNotify(EventManagement oldWidget) {
    return eventManagementData != oldWidget.eventManagementData;
  }

  static EventManager of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(EventManagement)
            as EventManagement)
        .eventManagementData;
  }
}

import 'package:flutter/material.dart';

import 'positionable_event.dart';

class EventsProvider extends InheritedWidget {
  EventsProvider({
    @required this.events,
    @required Widget child,
  })  : assert(events != null),
        super(child: child);

  final Set<PositionableEvent> events;

  @override
  bool updateShouldNotify(EventsProvider oldWidget) {
    return oldWidget.events != events;
  }

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}

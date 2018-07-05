import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/events/positionable_event.dart';

/// Function that returns a set of events that happen on some [day].
typedef Set<PositionableEvent> GetEventsOf(DateTime day);

class EventsProvider extends InheritedWidget {
  EventsProvider({
    @required this.getEventsOf,
    @required Widget child,
  })  : assert(getEventsOf != null),
        super(child: child);

  /// Returns a set of events that happen on [day].
  final GetEventsOf getEventsOf;

  @override
  bool updateShouldNotify(EventsProvider oldWidget) {
    return false;
  }

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}

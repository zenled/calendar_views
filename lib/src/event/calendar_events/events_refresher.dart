import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Function that forces refresh of events of some [day].
typedef void RefreshEventsOf(DateTime day);

/// Widget that can be prompted to refresh the events.
class EventsRefresher extends InheritedWidget {
  EventsRefresher({
    @required this.refreshEventsOf,
    @required this.refreshAllEvents,
    @required Widget child,
  })  : assert(refreshEventsOf != null),
        assert(refreshAllEvents != null),
        super(child: child);

  /// Forces a refresh of evens that happen on [day]
  final RefreshEventsOf refreshEventsOf;

  /// Forces a refresh of events of all days for which data has been previously fetched.
  final VoidCallback refreshAllEvents;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static EventsRefresher of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsRefresher);
  }
}

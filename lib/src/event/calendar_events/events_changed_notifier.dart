import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'events_changed_listener.dart';

/// Widget that can be subscribed, to be notified when evens change.
class EventsChangedNotifier extends InheritedWidget {
  EventsChangedNotifier({
    @required this.attach,
    @required this.detach,
    @required Widget child,
  })  : assert(attach != null),
        assert(detach != null),
        super(child: child);

  /// Attaches [EventsChangedListener].
  final EventsChangedListenerCallback attach;

  /// Detaches [EventsChangedListener].
  final EventsChangedListenerCallback detach;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static EventsChangedNotifier of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsChangedNotifier);
  }
}

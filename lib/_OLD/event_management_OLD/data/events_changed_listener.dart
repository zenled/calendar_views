import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

/// Class for listening when events of [day] change.
class EventsChangedListener {
  EventsChangedListener({
    @required this.day,
    @required this.onEventsChanged,
  })  : assert(day != null),
        assert(onEventsChanged != null);

  /// Listener is listening for change of events of this [day].
  final DateTime day;

  /// Function that fires when events of [day] change.
  final VoidCallback onEventsChanged;
}

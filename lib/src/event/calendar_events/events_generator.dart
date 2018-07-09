import 'dart:async';

import 'package:calendar_views/src/event/events/positionable_event.dart';

/// Base for a class that generates [PositionableEvent]s.
abstract class EventsGenerator {
  /// Returns a future with set of events that happen on [day].
  Future<Set<PositionableEvent>> generateEventsOf(DateTime day);
}

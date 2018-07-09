import 'package:calendar_views/src/event/events/positionable_event.dart';

/// Base for a class that can tell if some event should be shown.
abstract class EventsFilter<T extends PositionableEvent> {
  /// Returns true if [event] should be shown.
  bool shouldEventBeShown(T event);
}

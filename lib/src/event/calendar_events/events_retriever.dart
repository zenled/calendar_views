import 'dart:async';

import 'package:calendar_views/src/event/events/positionable_event.dart';

abstract class EventsRetriever {
  Future<Set<PositionableEvent>> retrieveEventsOf(DateTime day);
}

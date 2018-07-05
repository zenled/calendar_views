import 'dart:async';

import 'package:calendar_views/src/event/events/positionable_event.dart';

abstract class EventsOfDayRetriever {
  Future<Set<PositionableEvent>> retrieveEventsOfDat(DateTime day);
}

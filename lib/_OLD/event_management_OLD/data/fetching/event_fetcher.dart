import 'dart:async';

import 'package:calendar_views/event.dart';

abstract class EventFetcher {
  Future<Set<CalendarViewsEvent>> fetchEventsOnDay(DateTime day);
}

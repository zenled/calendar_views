import 'package:meta/meta.dart';

import 'package:calendar_views/src/internal_date_items/all.dart';
import 'package:calendar_views/src/event/events/positionable_event.dart';

class EventsStorage {
  EventsStorage() {
    _dateToEventsMap = new Map();
  }

  Map<Date, Set<PositionableEvent>> _dateToEventsMap;

  void store(
    Date date,
    Set<PositionableEvent> events,
  ) {
    _dateToEventsMap[date] = events;
  }

  Set<PositionableEvent> retrieveOf(Date date) {
    if (haveEventOfDayBeenStored(date)) {
      return _dateToEventsMap[date];
    } else {
      return new Set<PositionableEvent>();
    }
  }

  bool haveEventOfDayBeenStored(Date day) {
    return _dateToEventsMap.containsKey(day);
  }

  Set<Date> daysWhoseEventsHaveBeenStored() {
    return _dateToEventsMap.keys.toSet();
  }
}

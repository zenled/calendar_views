import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/event.dart';

class EventStorage {
  EventStorage() : _dateToEventsMap = new Map();

  final Map<Date, Set<CalendarViewsEvent>> _dateToEventsMap;

  /// Stores [events] of [date].
  ///
  /// If some events of this [date] are already stored they are overwritten.
  void store(
    Date date,
    Set<CalendarViewsEvent> events,
  ) {
    _dateToEventsMap[date] = events;
  }

  /// Returns events that have previously been stored for this [date].
  ///
  /// If no events for this [date] have been stored it return an empty set.
  Set<CalendarViewsEvent> retrieveOf(Date date) {
    if (haveEventsOfDateBeenStored(date)) {
      return _dateToEventsMap[date];
    } else {
      return new Set<CalendarViewsEvent>();
    }
  }

  /// Returns true if events of some [date] have been stored.
  bool haveEventsOfDateBeenStored(Date date) {
    return _dateToEventsMap.containsKey(date);
  }

  /// Returns days of which events have been stored.
  Set<Date> daysWhichEventsHaveBeenStored() {
    return _dateToEventsMap.keys.toSet();
  }
}

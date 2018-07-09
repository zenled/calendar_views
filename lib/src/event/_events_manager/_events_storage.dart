import 'package:calendar_views/src/_internal_date_items/all.dart';
import 'package:calendar_views/src/event/events/positionable_event.dart';

/// Class that handles storage of events.
class EventsStorage {
  EventsStorage() : _dateToEventsMap = new Map();

  final Map<Date, Set<PositionableEvent>> _dateToEventsMap;

  /// Stores [events] of [date].
  ///
  /// If some events of this [date] are already stored they are overwritten.
  void store(
    Date date,
    Set<PositionableEvent> events,
  ) {
    _dateToEventsMap[date] = events;
  }

  /// Returns events that have previously been stored for this [date].
  ///
  /// If no events for this [date] have been stored it return an empty set.
  Set<PositionableEvent> retrieveOf(Date date) {
    if (haveEventOfDayBeenStored(date)) {
      return _dateToEventsMap[date];
    } else {
      return new Set<PositionableEvent>();
    }
  }

  /// Returns true if events of some [date] have been stored.
  bool haveEventOfDayBeenStored(Date date) {
    return _dateToEventsMap.containsKey(date);
  }

  /// Returns days of which events have been stored.
  Set<Date> daysWhichEventsHaveBeenStored() {
    return _dateToEventsMap.keys.toSet();
  }
}

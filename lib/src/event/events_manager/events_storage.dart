part of events_manager;

class _EventsStorage {
  _EventsStorage() {
    _dayToEventsMap = new Map();
  }

  Map<Date, Set<PositionableEvent>> _dayToEventsMap;

  void storeEvents({
    @required Date day,
    @required Set<PositionableEvent> events,
  }) {
    _dayToEventsMap[day] = events;
  }

  Set<PositionableEvent> retrieveEventsOf({
    @required Date day,
  }) {
    if (haveEventOfDayBeenStored(day)) {
      return _dayToEventsMap[day];
    } else {
      return new Set<PositionableEvent>();
    }
  }

  bool haveEventOfDayBeenStored(Date day) {
    return _dayToEventsMap.containsKey(day);
  }

  Set<Date> daysWhoseEventsHaveBeenStored() {
    return _dayToEventsMap.keys.toSet();
  }
}

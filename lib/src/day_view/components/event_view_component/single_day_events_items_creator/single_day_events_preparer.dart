import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

/// Utility that prepares events of some [date].
class SingleDayEventsPreparer {
  SingleDayEventsPreparer({
    @required this.context,
    @required this.restrictions,
    @required this.filter,
    @required this.date,
  })  : assert(context != null),
        assert(restrictions != null),
        assert(date != null);

  final BuildContext context;

  final Restrictions restrictions;
  final EventsFilter filter;

  final DateTime date;

  Set<PositionableEvent> getAndPrepareEvents() {
    Set<PositionableEvent> events;

    events = _retrieveEvents();
    events = _removeAllDayEvents(events);
    events = _filterEvents(events);
    events = _extractFullyVisibleEvents(context, events);

    return events;
  }

  Set<PositionableEvent> _retrieveEvents() {
    return EventsProvider.of(context).getEventsOf(date: date);
  }

  Set<PositionableEvent> _removeAllDayEvents(
    Iterable<PositionableEvent> events,
  ) {
    return events.where((event) => !event.isAllDay).toSet();
  }

  Set<PositionableEvent> _filterEvents(Iterable<PositionableEvent> events) {
    if (filter != null) {
      return events.where((event) => filter.shouldEventBeShown(event)).toSet();
    } else {
      return events.toSet();
    }
  }

  Set<PositionableEvent> _extractFullyVisibleEvents(
    BuildContext context,
    Iterable<PositionableEvent> events,
  ) {
    int minimumMinuteOfDay = restrictions.minimumMinuteOfDay;
    int maximumMinuteOfDay = restrictions.maximumMinuteOfDay;

    return events
        .where(
          (event) =>
              event.beginMinuteOfDay >= minimumMinuteOfDay &&
              event.endMinuteOfDay <= maximumMinuteOfDay,
        )
        .toSet();
  }
}

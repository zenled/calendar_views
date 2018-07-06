import 'package:meta/meta.dart';

import 'package:calendar_views/src/_utils/all.dart';

import 'positionable_event.dart';

/// A base class that implements [PositionableEvent], for easier creation of custom events.
abstract class EventBase implements PositionableEvent {
  EventBase.allDay({
    @required DateTime date,
  })  : assert(date != null),
        isAllDay = true,
        year = date.year,
        month = date.month,
        day = date.day,
        weekday = date.weekday,
        beginMinuteOfDay = null,
        duration = null;

  EventBase({
    @required DateTime date,
    @required this.beginMinuteOfDay,
    @required this.duration,
  })  : assert(date != null),
        assert(beginMinuteOfDay != null &&
            beginMinuteOfDay >= minimum_minute_of_day &&
            beginMinuteOfDay <= maximum_minute_of_day),
        assert(duration != null &&
            (beginMinuteOfDay + duration) <= maximum_minute_of_day),
        isAllDay = false,
        year = date.year,
        month = date.month,
        day = date.day,
        weekday = date.weekday;

  final bool isAllDay;

  final int year;

  final int month;

  final int day;

  final int weekday;

  final int beginMinuteOfDay;

  final int duration;

  int get endMinuteOfDay => beginMinuteOfDay + duration;
}

import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart';

import 'positionable_event.dart';

class SimpleEvent implements PositionableEvent {
  SimpleEvent._internal({
    @required this.isAllDay,
    @required this.year,
    @required this.month,
    @required this.day,
    @required this.weekday,
    @required this.beginMinuteOfDay,
    @required this.duration,
    @required this.title,
    @required this.details,
  })  : assert(isAllDay != null),
        assert(year != null),
        assert(month != null),
        assert(day != null),
        assert(weekday != null),
        assert(title != null);

  factory SimpleEvent.allDay({
    @required DateTime date,
    @required String title,
    String details,
  }) {
    assert(date != null);

    return new SimpleEvent._internal(
      isAllDay: true,
      year: date.year,
      month: date.month,
      day: date.day,
      weekday: date.weekday,
      beginMinuteOfDay: null,
      duration: null,
      title: title,
      details: details,
    );
  }

  factory SimpleEvent({
    @required DateTime date,
    @required int beginMinuteOfDay,
    @required int duration,
    @required String title,
    String details,
  }) {
    assert(date != null);
    assert(beginMinuteOfDay != null &&
        beginMinuteOfDay >= minimum_minute_of_day &&
        beginMinuteOfDay <= maximum_minute_of_day);
    assert(duration != null &&
        (beginMinuteOfDay + duration) <= maximum_minute_of_day);

    return new SimpleEvent._internal(
      isAllDay: false,
      year: date.year,
      month: date.month,
      day: date.day,
      weekday: date.weekday,
      beginMinuteOfDay: beginMinuteOfDay,
      duration: duration,
      title: title,
      details: details,
    );
  }

  final bool isAllDay;

  final int year;

  final int month;

  final int day;

  final int weekday;

  final int beginMinuteOfDay;

  final int duration;

  int get endMinuteOfDay => beginMinuteOfDay + endMinuteOfDay;

  final String title;

  final String details;
}

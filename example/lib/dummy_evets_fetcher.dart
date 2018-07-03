import 'dart:async';

import 'package:calendar_views/calendar_views.dart';

Future<Set<PositionableEvent>> dummyEventsFetcher(DateTime date) async {
  await new Future.delayed(new Duration(seconds: 1));

  DateTime now = new DateTime.now();
  if (_isSameDate(now, date)) {
    await new Future.delayed(new Duration(seconds: 1));
    return _generateEvents1(date);
  } else {
    await new Future.delayed(new Duration(seconds: 2));
    return _generateEvents2(date);
  }
}

bool _isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Set<PositionableEvent> _generateEvents1(DateTime date) {
  return <PositionableEvent>[
    new SimpleEvent.allDay(
      date: date,
      title: "All day event",
    ),
    new SimpleEvent(
      date: date,
      beginMinuteOfDay: 7 * 60,
      duration: 60,
      title: "Abc",
    ),
    new SimpleEvent(
      date: date,
      beginMinuteOfDay: 7 * 60,
      duration: 60,
      title: "Abc",
    ),
    new SimpleEvent(
      date: date,
      beginMinuteOfDay: 7 * 60,
      duration: 90,
      title: "Def",
    ),
    new SimpleEvent(
      date: date,
      beginMinuteOfDay: 8 * 60,
      duration: 60,
      title: "Abc",
    )
  ].toSet();
}

Set<PositionableEvent> _generateEvents2(DateTime date) {
  return <PositionableEvent>[
    new SimpleEvent(
      date: date,
      beginMinuteOfDay: 7 * 60,
      duration: 120,
      title: "AAbc",
    ),
  ].toSet();
}

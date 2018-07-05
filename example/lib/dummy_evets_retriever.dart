import 'dart:async';

import 'package:calendar_views/event.dart';

class DummyEventsRetriever implements EventsRetriever {
  @override
  Future<Set<PositionableEvent>> retrieveEventsOf(DateTime day) async {
    await new Future.delayed(new Duration(seconds: 1));

    if (_isSameDate(day, new DateTime.now())) {
      return _generateEvents1(day);
    } else {
      await new Future.delayed(new Duration(seconds: 1));
      return _generateEvents2(day);
    }
  }

  Set<PositionableEvent> _generateEvents1(DateTime day) {
    return <PositionableEvent>[
      new SimpleEvent.allDay(
        date: day,
        title: "All day event",
      ),
      new SimpleEvent(
        date: day,
        beginMinuteOfDay: 7 * 60,
        duration: 60,
        title: "Abc",
      ),
      new SimpleEvent(
        date: day,
        beginMinuteOfDay: 7 * 60,
        duration: 60,
        title: "Abc",
      ),
      new SimpleEvent(
        date: day,
        beginMinuteOfDay: 7 * 60,
        duration: 90,
        title: "Def",
      ),
      new SimpleEvent(
        date: day,
        beginMinuteOfDay: 8 * 60,
        duration: 60,
        title: "Abc",
      )
    ].toSet();
  }

  Set<PositionableEvent> _generateEvents2(DateTime day) {
    return <PositionableEvent>[
      new SimpleEvent(
        date: day,
        beginMinuteOfDay: 7 * 60,
        duration: 120,
        title: "AAbc",
      ),
    ].toSet();
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

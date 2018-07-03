import 'package:meta/meta.dart';

@immutable
abstract class PositionableEvent {
  /// True is events is an all day event.
  ///
  /// This should be treated differently than event that start at 0:00 and end at 24:00.
  bool get isAllDay;

  /// Minute of day at which the event starts (inclusive).
  ///
  /// If event [isAllDay] this should be null.
  int get beginMinuteOfDay;

  /// Duration of the event.
  ///
  /// If event [isAllDay] this should return null.
  int get duration;

  /// Minute of day at which the event ends (inclusive).
  ///
  /// If event [isAllDay] this should return null.
  int get endMinuteOfDay => beginMinuteOfDay + duration;

  int get year;

  int get month;

  int get day;

  int get weekday;
}

typedef void PositionableEventsSorter(List<PositionableEvent> events);

void sortPositionableEvents(List<PositionableEvent> events) {
  events.sort((PositionableEvent event1, PositionableEvent event2) {
    if (event1.isAllDay && event2.isAllDay) {
      return 0;
    }
    if (event1.isAllDay && !event2.isAllDay) {
      return -1;
    }
    if (!event1.isAllDay && event2.isAllDay) {
      return 1;
    }
    // neater event1 and event2 are allDayEvents
    if (event1.beginMinuteOfDay != event2.beginMinuteOfDay) {
      return event1.beginMinuteOfDay.compareTo(event2.beginMinuteOfDay);
    } else {
      return event1.duration.compareTo(event2.duration) * -1;
    }
  });
}

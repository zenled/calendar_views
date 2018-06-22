import 'package:meta/meta.dart';

@immutable
abstract class PositionableEvent {
  int get beginMinuteOfDay;

  int get duration;
}

void sortPositionableEvents(List<PositionableEvent> events) {
  events.sort((PositionableEvent event1, PositionableEvent event2) {
    if (event1.beginMinuteOfDay != event2.beginMinuteOfDay) {
      return event1.beginMinuteOfDay.compareTo(event2.beginMinuteOfDay);
    } else {
      return event1.duration.compareTo(event2.duration) * -1;
    }
  });
}

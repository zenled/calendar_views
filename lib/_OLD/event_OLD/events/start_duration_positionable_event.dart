import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

@immutable
abstract class StartDurationPositionableEvent extends CalendarViewsEvent {
  const StartDurationPositionableEvent();

  int get startMinuteOfDay;

  int get duration;
}

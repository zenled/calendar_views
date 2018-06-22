import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart';

import 'positionable_event.dart';

class SimpleEvent implements PositionableEvent {
  SimpleEvent({
    @required this.beginMinuteOfDay,
    @required this.duration,
    @required this.title,
    this.details,
  })  : assert(
            beginMinuteOfDay != null && isValidMinuteOfDay(beginMinuteOfDay)),
        assert(duration != null && duration >= 0),
        assert(title != null);

  final int beginMinuteOfDay;

  final int duration;

  final String title;

  final String details;
}

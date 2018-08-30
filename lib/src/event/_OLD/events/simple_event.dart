import 'package:meta/meta.dart';

import 'event_base.dart';

/// Event that has a title and optionally some details.
class SimpleEvent extends EventBase {
  SimpleEvent.allDay({
    @required DateTime date,
    @required this.title,
    this.details,
  })  : assert(title != null),
        super.allDay(date: date);

  SimpleEvent({
    @required DateTime date,
    @required int beginMinuteOfDay,
    @required int duration,
    @required this.title,
    this.details,
  })  : assert(title != null),
        super(
          date: date,
          beginMinuteOfDay: beginMinuteOfDay,
          duration: duration,
        );

  final String title;

  final String details;
}

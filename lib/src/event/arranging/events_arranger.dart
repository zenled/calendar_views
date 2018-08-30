import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

/// Base for a class that arranges events.
abstract class EventsArranger {
  /// Arranges [events] while concerning [constraints] and  returns a list of [ArrangedEvent]s.
  List<ArrangedEvent> arrangeEvents({
    @required List<TimePositionableEvent> events,
    @required ArrangerConstraints constraints,
  });
}

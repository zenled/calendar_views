import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Base for a class that arranges events.
abstract class EventViewArranger {
  /// Arranges [events] while concerning [constraints] and  returns a list of [ArrangedEvent]s.
  List<ArrangedEvent> arrangeEvents({
    @required Set<ItemWithStartDuration> events,
    @required ArrangerConstraints constraints,
  });
}

import 'package:calendar_views/day_view.dart';

/// Base for a class that arranges events displayed by [EventViewComponent].
abstract class EventViewArranger {
  /// Arranges [events] while concerning [constraints] and returns a list of [ArrangedEvent]s.
  List<ArrangedEvent> arrangeEvents(
    Iterable<StartDurationItem> events,
    ArrangerConstraints constraints,
  );
}

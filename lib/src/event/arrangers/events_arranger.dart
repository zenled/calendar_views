import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/events/positionable_event.dart';
import 'arranged_event.dart';
import 'arranger_constraints.dart';

abstract class EventsArranger {
  /// Returns a list of [ArrangedEvent]s.
  List<ArrangedEvent> arrangeEvents({
    @required Set<PositionableEvent> events,
    @required ArrangerConstraints constraints,
  });
}

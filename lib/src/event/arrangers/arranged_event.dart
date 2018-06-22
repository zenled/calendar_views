import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/calendar_items.dart';

@immutable
class ArrangedEvent<I extends PositionableEvent> {
  ArrangedEvent({
    @required this.position,
    @required this.size,
    @required this.event,
  })  : assert(position != null),
        assert(size != null),
        assert(event != null);

  final Position position;

  final Size size;

  final I event;
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/event.dart';

/// Signature for a function that builds a Event.
typedef Positioned EventBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required T event,
});

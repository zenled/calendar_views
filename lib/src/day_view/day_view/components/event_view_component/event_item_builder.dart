import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/event.dart';

/// Signature for a function that builds a Event.
///
/// Event should be encapsulated inside a [Positioned] widget.
typedef Positioned EventItemBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required TimePositionableEvent event,
});

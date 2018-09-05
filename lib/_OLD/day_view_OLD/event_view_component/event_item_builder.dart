import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

import '../item_position.dart';
import '../item_size.dart';

/// Signature for a function that builds a Event.
///
/// Event should be encapsulated inside a [Positioned] widget.
typedef Positioned EventBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required PositionableEvent event,
});

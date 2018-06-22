import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/event.dart';

typedef Positioned SingleDayEventBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required T event,
});

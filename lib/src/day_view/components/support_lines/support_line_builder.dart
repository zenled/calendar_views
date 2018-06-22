import 'package:flutter/material.dart';

import 'package:calendar_views/calendar_items.dart';

/// Signature for a function that builds a SupportLine.
typedef Positioned SupportLineBuilder({
  @required BuildContext context,
  @required Position position,
  @required double width,
  @required int minuteOfDay,
});

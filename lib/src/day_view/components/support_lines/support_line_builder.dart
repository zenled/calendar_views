import 'package:flutter/material.dart';

import 'package:calendar_views/calendar_items.dart';

typedef Positioned SupportLineBuilder({
  @required BuildContext context,
  @required Location location,
  @required double width,
  @required int minuteOfDay,
});

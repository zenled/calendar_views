import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_items/location.dart';

import 'time_indicator_properties.dart';

typedef Positioned TimeIndicatorBuilder({
  @required BuildContext context,
  @required Location location,
  @required Size size,
  @required TimeIndicatorProperties properties,
});

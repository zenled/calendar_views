import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_items/position.dart';

import 'time_indicator_properties.dart';

/// Signature for a function that builds a TimeIndicator.
typedef Positioned TimeIndicatorBuilder({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required TimeIndicatorProperties properties,
});

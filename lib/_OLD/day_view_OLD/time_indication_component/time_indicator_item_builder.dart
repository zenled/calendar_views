import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../item_position.dart';
import '../item_size.dart';
import 'time_indicator_properties.dart';

/// Signature for a function that builds a TimeIndicator.
typedef Positioned TimeIndicatorItemBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required TimeIndicatorProperties properties,
});

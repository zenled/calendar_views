import 'package:flutter/material.dart';

import '../item_position.dart';
import 'support_line_properties.dart';

/// Signature for a function that builds a SupportLine.
typedef Positioned SupportLineItemBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required double width,
  @required SupportLineProperties properties,
});

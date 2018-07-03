import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../item_position.dart';
import '../item_size.dart';
import 'day_separation_properties.dart';

typedef DaySeparationItemBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required DaySeparationProperties properties,
});

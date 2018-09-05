import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

typedef Positioned ItemWithTimeBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required double width,
  @required ItemWithTime item,
});

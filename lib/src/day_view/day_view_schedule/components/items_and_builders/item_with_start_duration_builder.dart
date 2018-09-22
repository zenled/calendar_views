import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

typedef Positioned ItemWithStartDurationBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required ItemWithStartDuration item,
});

import 'package:flutter/material.dart';

import 'day_view_days_header.dart';

/// Signature that builds an item inside a [DayViewDaysHeader].
///
/// Properties of [day] except for year, month and day are set to their default values.
typedef Widget DayViewDaysHeaderItemBuilder(
  BuildContext context,
  DateTime day,
  String userId,
);

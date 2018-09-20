import 'package:flutter/material.dart';

import 'month_view.dart';

/// Signature for a function that builds a header item inside a [MonthView].
///
/// Just as with [DateTime], weekdays start with 1 (Monday: 1).
typedef Widget MonthViewHeaderItemBuilder(
  BuildContext context,
  int weekday,
);

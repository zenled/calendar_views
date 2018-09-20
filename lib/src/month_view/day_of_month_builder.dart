import 'package:flutter/material.dart';

import 'day_of_month.dart';
import 'month_view.dart';

/// Signature for a function that builds a day inside a [MonthView].
typedef Widget DayOfMonthBuilder(
  BuildContext context,
  DayOfMonth dayOfMonth,
);

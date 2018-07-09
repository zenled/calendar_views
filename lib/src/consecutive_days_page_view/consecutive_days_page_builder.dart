import 'package:flutter/material.dart';

import 'consecutive_days_page_view.dart';

/// Signature for a function that builds a page in a [ConsecutiveDaysPageView].
///
/// Values of each day in [consecutiveDays] except for year,month and day are set to their default values.
typedef Widget ConsecutiveDaysPageBuilder(
  BuildContext context,
  List<DateTime> consecutiveDays,
);

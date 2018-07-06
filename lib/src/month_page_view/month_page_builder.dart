import 'package:flutter/material.dart';

import 'month_page_view.dart';

/// Signature for a function that builds a page in a [MonthPageView].
///
/// Values of [month] except year and month are set to default values.
typedef Widget MonthPageBuilder(
  BuildContext context,
  DateTime month,
);

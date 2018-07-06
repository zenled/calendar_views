import 'package:flutter/material.dart';

import 'day_page_view.dart';

/// Signature for a function that builds a page in a [DayPageView].
///
/// Values of [day] except year and month and day are set to default values.
typedef Widget DayPageBuilder(BuildContext context, DateTime day);

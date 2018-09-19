import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'month_page_view.dart';

/// Utility for validating [MonthPageView.minimumMonth] and [MonthPageView.maximumMonth].
///
/// If any property is invalid it throws an [ArgumentError].
class ConstraintsValidator {
  ConstraintsValidator({
    @required this.minimumMonth,
    @required this.maximumMonth,
  });

  final Month minimumMonth;
  final Month maximumMonth;

  void validateMinimumMonth() {
    if (minimumMonth == null) {
      throw new ArgumentError.notNull("minimumMonth");
    }
  }

  void validateMaximumMonth() {
    if (maximumMonth == null) {
      return;
    }

    if (maximumMonth.isBefore(minimumMonth)) {
      throw new ArgumentError.value(
        maximumMonth.toDateTime(),
        "maximumMonth",
        "maximumMonth must not be before minimumMonth",
      );
    }
  }
}

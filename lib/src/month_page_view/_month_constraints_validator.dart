import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

class MonthConstraintsValidator {
  MonthConstraintsValidator({
    @required this.minimumMonth,
    @required this.maximumMonth,
  });

  final Month minimumMonth;
  final Month maximumMonth;

  void throwArgumentErrorIfInvalidMinimumMonth() {
    if (minimumMonth == null) {
      throw new ArgumentError.notNull("minimumMonth");
    }
  }

  void throwArgumentErrorIfInvalidMaximumMonth() {
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

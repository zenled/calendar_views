import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import '_page_days.dart';

@immutable
class PageDaysValidator {
  PageDaysValidator({
    @required this.pageDays,
  }) : assert(pageDays != null);

  final PageDays pageDays;

  void validate() {
    _validateDaysPerPage();
    _validateMaximumDay();
  }

  void _validateDaysPerPage() {
    int daysPerPage = pageDays.daysPerPage;

    if (daysPerPage <= 0) {
      throw new Exception("daysPerPage should be > 0");
    }
  }

  void _validateMaximumDay() {
    Date maximumDay = pageDays.maximumDay;

    if (maximumDay.isBefore(pageDays.minimumDay)) {
      throw new Exception("maximumDay should be on or after minimumDay");
    }
  }
}

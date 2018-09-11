import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

class MaximumDateAdjuster {
  MaximumDateAdjuster({
    @required this.daysPerPage,
    @required this.minimumDate,
    @required this.maximumDateCandidate,
  })  : assert(daysPerPage != null && daysPerPage > 0),
        assert(minimumDate != null),
        assert(maximumDateCandidate != null &&
            (maximumDateCandidate == minimumDate ||
                maximumDateCandidate.isAfter(minimumDate)));

  final int daysPerPage;

  final Date minimumDate;
  final Date maximumDateCandidate;

  Date adjust() {
    Date maximumDay = maximumDateCandidate;

    while (!(_isLastDayOfPage(maximumDay))) {
      maximumDay = maximumDay.addDays(1);
    }

    return maximumDay;
  }

  bool _isLastDayOfPage(Date day) {
    return _dayOfPage(day) == daysPerPage - 1;
  }

  int _dayOfPage(Date day) {
    int daysBetween = minimumDate.daysBetween(day);
    daysBetween = daysBetween.abs();

    return daysBetween % daysPerPage;
  }
}

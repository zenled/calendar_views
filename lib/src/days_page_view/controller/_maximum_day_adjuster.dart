import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

class MaximumDayAdjuster {
  MaximumDayAdjuster({
    @required this.daysPerPage,
    @required this.minimumDay,
    @required this.maximumDayCandidate,
  })  : assert(daysPerPage != null && daysPerPage > 0),
        assert(minimumDay != null),
        assert(maximumDayCandidate != null &&
            (maximumDayCandidate == minimumDay ||
                maximumDayCandidate.isAfter(minimumDay)));

  final int daysPerPage;

  final Date minimumDay;
  final Date maximumDayCandidate;

  Date adjust() {
    Date maximumDay = maximumDayCandidate;

    while (!(_isLastDayOfPage(maximumDay))) {
      maximumDay = maximumDay.addDays(1);
    }

    return maximumDay;
  }

  bool _isLastDayOfPage(Date day) {
    return _dayOfPage(day) == daysPerPage - 1;
  }

  int _dayOfPage(Date day) {
    int daysBetween = minimumDay.daysBetween(day);
    daysBetween = daysBetween.abs();

    return daysBetween % daysPerPage;
  }
}

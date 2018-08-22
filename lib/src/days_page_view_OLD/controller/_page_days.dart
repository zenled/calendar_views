import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import '_maximum_day_adjuster.dart';

@immutable
class PageDays {
  PageDays({
    @required this.daysPerPage,
    @required this.minimumDay,
    @required Date maximumDayCandidate,
  })  : assert(daysPerPage != null),
        assert(minimumDay != null),
        maximumDay = _adjustMaximumDayToSatisfyDaysPerPage(
          daysPerPage: daysPerPage,
          minimumDay: minimumDay,
          maximumDayCandidate: maximumDayCandidate,
        );

  final int daysPerPage;

  final Date minimumDay;
  final Date maximumDay;

  bool get isInfinite => maximumDay == null;

  int get numberOfPages {
    if (isInfinite) {
      return null;
    } else {
      return (minimumDay.daysBetween(maximumDay) ~/ daysPerPage) + 1;
    }
  }

  int pageOfDay(Date day) {
    if (day.isBefore(minimumDay)) {
      return 0;
    }
    if (!isInfinite && day.isAfter(maximumDay)) {
      return numberOfPages - 1;
    } else {
      int daysFromMinimumDay = minimumDay.daysBetween(day);
      return daysFromMinimumDay ~/ daysPerPage;
    }
  }

  Date getFirstDayOfPage(int page) {
    assert(page >= 0);

    return minimumDay.addDays(page * daysPerPage);
  }

  List<Date> daysOfPage(int page) {
    List<Date> days = <Date>[];

    Date firstDay = getFirstDayOfPage(page);
    for (int i = 0; i < daysPerPage; i++) {
      days.add(
        firstDay.addDays(i),
      );
    }

    return days;
  }

  static Date _adjustMaximumDayToSatisfyDaysPerPage({
    @required int daysPerPage,
    @required Date minimumDay,
    @required Date maximumDayCandidate,
  }) {
    if (maximumDayCandidate == null) {
      return null;
    } else {
      MaximumDayAdjuster maximumDayAdjuster = new MaximumDayAdjuster(
        daysPerPage: daysPerPage,
        minimumDay: minimumDay,
        maximumDayCandidate: maximumDayCandidate,
      );
      return maximumDayAdjuster.adjust();
    }
  }
}

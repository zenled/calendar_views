import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

@immutable
class PageDays {
  PageDays({
    @required this.daysPerPage,
    @required this.minimumDate,
    this.maximumDate,
  })  : assert(daysPerPage != null),
        assert(minimumDate != null);

  final int daysPerPage;

  final Date minimumDate;
  final Date maximumDate;

  bool get isInfinite => maximumDate == null;

  int get numberOfPages {
    if (isInfinite) {
      return null;
    } else {
      return (minimumDate.daysBetween(maximumDate) ~/ daysPerPage) + 1;
    }
  }

  int pageOfDate(Date date) {
    if (date.isBefore(minimumDate)) {
      return 0;
    }
    if (!isInfinite && date.isAfter(maximumDate)) {
      return numberOfPages - 1;
    } else {
      int daysFromMinimumDay = minimumDate.daysBetween(date);
      return daysFromMinimumDay ~/ daysPerPage;
    }
  }

  Date getFirstDateOfPage(int page) {
    assert(page >= 0);

    return minimumDate.addDays(page * daysPerPage);
  }

  List<Date> datesOfPage(int page) {
    List<Date> days = <Date>[];

    Date firstDay = getFirstDateOfPage(page);
    for (int i = 0; i < daysPerPage; i++) {
      days.add(
        firstDay.addDays(i),
      );
    }

    return days;
  }
}

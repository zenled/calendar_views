import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Utility for determining which days belong to which page.
@immutable
class PageDays {
  PageDays({
    @required this.initialPage,
    @required this.firstDayOfInitialPage,
    @required this.daysPerPage,
  })  : assert(initialPage != null),
        assert(firstDayOfInitialPage != null),
        assert(daysPerPage != null && daysPerPage > 0);

  final int initialPage;
  final Date firstDayOfInitialPage;
  final int daysPerPage;

  /// Returns days that belongs to [page].
  List<Date> daysOfPage(int page) {
    List<Date> daysOfPage = <Date>[];

    Date firstDayOfPage = _getFirstDayOfPage(page);
    for (int i = 0; i < daysPerPage; i++) {
      daysOfPage.add(
        firstDayOfPage.addDays(i),
      );
    }

    return daysOfPage;
  }

  /// Returns page of which [day] is part of.
  int pageOfDay(Date day) {
    int deltaDays = firstDayOfInitialPage.daysBetween(day);
    double deltaPages = deltaDays / daysPerPage;
    int deltaPagesInt = deltaPages.floor();

    return initialPage + deltaPagesInt;
  }

  Date _getFirstDayOfPage(int page) {
    int deltaFromInitialPage = page - initialPage;

    return firstDayOfInitialPage.addDays(daysPerPage * deltaFromInitialPage);
  }
}

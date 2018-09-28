import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Utility for determining which [Month] belongs to which page.
@immutable
class PageMonth {
  PageMonth({
    @required this.initialPage,
    @required this.initialMonth,
  })  : assert(initialPage != null),
        assert(initialMonth != null);

  final int initialPage;
  final Month initialMonth;

  /// Returns [Month] that belongs to [page].
  Month monthOfPage(int page) {
    int deltaFromInitialPage = page - initialPage;

    return initialMonth.addMonths(deltaFromInitialPage);
  }

  /// Returns page that belongs to [month].
  int pageOfMonth(Month month) {
    int deltaFromInitialMonth = initialMonth.monthsBetween(month);

    return initialPage + deltaFromInitialMonth;
  }
}

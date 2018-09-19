import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'month_page_view.dart';

/// Utility for determining which month should be displayed on which page in a [MonthPageView].
@immutable
class PageMonth {
  PageMonth({
    @required this.minimumMonth,
    @required this.maximumMonth,
  }) : assert(minimumMonth != null);

  final Month minimumMonth;
  final Month maximumMonth;

  bool get _isConstrained => maximumMonth != null;

  /// Returns the number of pages that a [MonthPageView] should be able to display.
  ///
  /// Returns null if [MonthPageView] should be infinite.
  int get numberOfPages {
    if (_isConstrained) {
      return minimumMonth.monthsBetween(maximumMonth) + 1;
    } else {
      return null;
    }
  }

  /// Returns [Month] that should be displayed on [page].
  Month monthOfPage(int page) {
    assert(page >= 0);

    return minimumMonth.addMonths(page);
  }

  /// Returns page that displays [month].
  ///
  /// If [month] is before [minimumMonth] it returns the first page.
  /// If [month] is after [maximumMonth] it returns the last page.
  int pageOfMonth(Month month) {
    if (month.isBefore(minimumMonth)) {
      return 0;
    } else if (_isConstrained && month.isAfter(maximumMonth)) {
      return numberOfPages - 1;
    } else {
      return minimumMonth.monthsBetween(month);
    }
  }
}

import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

@immutable
class PageMonth {
  PageMonth({
    @required this.minimumMonth,
    @required this.maximumMonth,
  }) : assert(minimumMonth != null);

  final Month minimumMonth;
  final Month maximumMonth;

  bool get _isConstrained => maximumMonth != null;

  int get numberOfPages {
    if (_isConstrained) {
      return minimumMonth.monthsBetween(maximumMonth) + 1;
    } else {
      return null;
    }
  }

  Month monthOfPage(int page) {
    assert(page >= 0);

    return minimumMonth.addMonths(page);
  }

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

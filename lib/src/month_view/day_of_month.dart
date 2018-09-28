import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'month_view.dart';

/// Properties of a day displayed inside a [MonthView].
@immutable
class DayOfMonth {
  DayOfMonth({
    @required DateTime day,
    @required DateTime month,
  })  : assert(day != null),
        assert(month != null),
        this.day = new DateTime(day.year, day.month, day.day),
        this.month = new DateTime(month.year, month.month);

  /// Day to which this properties apply to.
  ///
  /// Properties of [day] except for year, month and day are set to their default values.
  final DateTime day;

  /// [MonthView.month] that this day belongs to.
  ///
  /// Properties of [month] except for year and month are set to their default values.
  final DateTime month;

  /// If true the [day] is not part of [month] but is extended from it.
  bool get isExtended => isExtendedBefore || isExtendedAfter;

  /// If true the [day] is extended before the [month].
  bool get isExtendedBefore => _monthOfDay.isBefore(_monthOfMonth);

  /// If true the [day] is extended after the [month].
  bool get isExtendedAfter => _monthOfDay.isAfter(_monthOfMonth);

  Month get _monthOfDay => new Month.fromDateTime(day);

  Month get _monthOfMonth => new Month.fromDateTime(month);

  @override
  String toString() {
    return 'DayOfMonthProperties{"'
        "day: ${day.year}.${day.month}.${day.day}, "
        "month: ${month.year}.${month.month}, "
        "isExtendedBefore: $isExtendedBefore, "
        "isExtendedAfter: $isExtendedAfter"
        "}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayOfMonth &&
          isSameDate(day, other.day) &&
          isSameYearAndMonth(month, other.month);

  @override
  int get hashCode => hash2(day, month);
}

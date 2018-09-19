import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'month_view.dart';

/// Properties of day displayed inside [MonthView].
@immutable
class DayOfMonthProperties {
  DayOfMonthProperties._internal({
    @required this.date,
    @required this.isExtended,
    @required this.month,
  })  : assert(date != null),
        assert(isExtended != null),
        assert(month != null);

  /// Returns properties of a non-extended day.
  factory DayOfMonthProperties({
    @required DateTime date,
  }) {
    assert(date != null);

    return new DayOfMonthProperties._internal(
      date: date,
      isExtended: false,
      month: new DateTime(date.year, date.month),
    );
  }

  /// Returns properties of day that is extended from some month.
  factory DayOfMonthProperties.ofExtendedDay({
    @required DateTime date,
    @required DateTime extendedFromMonth,
  }) {
    assert(extendedFromMonth != null);

    return new DayOfMonthProperties._internal(
      date: date,
      isExtended: true,
      month: new DateTime(extendedFromMonth.year, extendedFromMonth.month),
    );
  }

  /// Date to which this properties apply to.
  ///
  /// Values of [date] except for year, month and day should be set to their default values.
  final DateTime date;

  /// If true, this day does not belong to month that [MonthView] is displaying.
  final bool isExtended;

  /// Month for which day of extended day this properties belong to.
  ///
  /// Values of [month] except for year and month should be se to their default values.
  final DateTime month;

  /// If true this day is extended before the [month].
  bool get isExtendedBefore {
    if (isExtended) {
      return date.isBefore(month);
    } else {
      return false;
    }
  }

  /// If true this day is extended after the [month].
  bool get isExtendedAfter {
    if (isExtended) {
      return date.isAfter(month);
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return "DayOfMonthProperties"
        "{date: ${date.year}.${date.month}.${date.day}, "
        "isExtended: $isExtended, month: ${month.year}.${month.month}}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayOfMonthProperties &&
          runtimeType == other.runtimeType &&
          isSameDate(date, other.date) &&
          isExtended == other.isExtended &&
          isSameYearAndMonth(date, other.date);

  @override
  int get hashCode => hash3(
        date,
        isExtended,
        month,
      );
}

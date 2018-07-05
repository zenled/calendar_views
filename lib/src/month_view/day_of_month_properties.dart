import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;

@immutable
class DayOfMonthProperties {
  DayOfMonthProperties._internal({
    @required this.date,
    @required this.isExtended,
    @required this.month,
  })  : assert(date != null),
        assert(isExtended != null),
        assert(month != null);

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

  factory DayOfMonthProperties.forExtendedDay({
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

  final DateTime date;

  final bool isExtended;

  final DateTime month;

  bool get isExtendedBefore {
    if (isExtended) {
      return date.isBefore(month);
    } else {
      return false;
    }
  }

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
          utils.isSameDate(date, other.date) &&
          isExtended == other.isExtended &&
          utils.isSameYearAndMonth(date, other.date);

  @override
  int get hashCode => date.hashCode ^ isExtended.hashCode ^ month.hashCode;
}

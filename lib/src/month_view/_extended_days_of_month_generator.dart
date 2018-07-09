import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_items/all.dart';
import 'package:calendar_views/src/_utils/all.dart' as utils;

import 'day_of_month_properties.dart';

/// Class that can generate extended days of month.
@immutable
class ExtendedDaysOfMonthGenerator {
  ExtendedDaysOfMonthGenerator({
    @required DateTime month,
    @required this.firstWeekday,
  })  : assert(month != null),
        assert(firstWeekday != null && utils.isValidWeekday(firstWeekday)),
        _month = new Month.fromDateTime(month);

  final Month _month;

  final int firstWeekday;

  DateTime get month => _month.toDateTime();

  List<DayOfMonthProperties> generate() {
    List<DayOfMonthProperties> extendedDaysOfMonth = <DayOfMonthProperties>[];

    extendedDaysOfMonth.addAll(
      _generateExtendedDaysBeforeMonth(),
    );

    extendedDaysOfMonth.addAll(
      _generateDaysOfMonth(),
    );

    extendedDaysOfMonth.addAll(
      _generateExtendedDaysAfterMonth(
        lastDayOfMonth: extendedDaysOfMonth.last.date,
      ),
    );

    return extendedDaysOfMonth;
  }

  List<DayOfMonthProperties> _generateExtendedDaysBeforeMonth() {
    List<DayOfMonthProperties> extendedDays = <DayOfMonthProperties>[];

    Date date =
        _month.toDateAsFirstDayOfMonth().lowerToFirstWeekday(firstWeekday);
    while (!date.isOfMonth(_month)) {
      extendedDays.add(
        new DayOfMonthProperties.ofExtendedDay(
          date: date.toDateTime(),
          extendedFromMonth: month,
        ),
      );

      date = date.add(days: 1);
    }

    return extendedDays;
  }

  List<DayOfMonthProperties> _generateDaysOfMonth() {
    List<DayOfMonthProperties> daysOfMonth = <DayOfMonthProperties>[];

    Date date = _month.toDateAsFirstDayOfMonth();
    while (date.isOfMonth(_month)) {
      daysOfMonth.add(
        new DayOfMonthProperties(
          date: date.toDateTime(),
        ),
      );

      date = date.add(days: 1);
    }

    return daysOfMonth;
  }

  List<DayOfMonthProperties> _generateExtendedDaysAfterMonth({
    @required DateTime lastDayOfMonth,
  }) {
    assert(lastDayOfMonth != null);

    List<DayOfMonthProperties> extendedDays = <DayOfMonthProperties>[];

    Date date = new Date.fromDateTime(lastDayOfMonth);
    date = date.add(days: 1);
    while (date.weekday != firstWeekday) {
      extendedDays.add(
        new DayOfMonthProperties.ofExtendedDay(
          date: date.toDateTime(),
          extendedFromMonth: month,
        ),
      );

      date = date.add(days: 1);
    }

    return extendedDays;
  }
}

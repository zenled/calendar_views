import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;
import 'package:calendar_views/src/internal_date_items/all.dart';

import 'day_of_month_properties.dart';

@immutable
class ExtendedDaysOfMonthGenerator {
  ExtendedDaysOfMonthGenerator({
    @required DateTime month,
    @required this.firstWeekday,
  })  : assert(month != null),
        assert(utils.isValidWeekday(firstWeekday)),
        _month = new Month.fromDateTime(month);

  final Month _month;

  final int firstWeekday;

  DateTime get monthAsDateTime => _month.toDateTime();

  List<DayOfMonthProperties> generate() {
    List<DayOfMonthProperties> extendedDaysOfMonth = <DayOfMonthProperties>[];

    extendedDaysOfMonth.addAll(
      _generateExtendedDaysBefore(),
    );

    extendedDaysOfMonth.addAll(
      _generateDaysOfMonth(),
    );

    extendedDaysOfMonth.addAll(
      _generateExtendedDaysAfter(extendedDaysOfMonth.last.date),
    );

    return extendedDaysOfMonth;
  }

  List<DayOfMonthProperties> _generateExtendedDaysBefore() {
    List<DayOfMonthProperties> extendedDays = <DayOfMonthProperties>[];

    Date date =
        _month.toDateAsFirstDayOfMonth().lowerToFirstWeekday(firstWeekday);
    while (!date.isOfMonth(_month)) {
      extendedDays.add(
        new DayOfMonthProperties.forExtendedDay(
          date: date.toDateTime(),
          extendedFromMonth: monthAsDateTime,
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

  List<DayOfMonthProperties> _generateExtendedDaysAfter(
    DateTime lastDayOfMonth,
  ) {
    List<DayOfMonthProperties> extendedDays = <DayOfMonthProperties>[];

    Date date = new Date.fromDateTime(lastDayOfMonth);
    date = date.add(days: 1);
    while (date.weekday != firstWeekday) {
      extendedDays.add(
        new DayOfMonthProperties.forExtendedDay(
          date: date.toDateTime(),
          extendedFromMonth: monthAsDateTime,
        ),
      );

      date = date.add(days: 1);
    }

    return extendedDays;
  }
}

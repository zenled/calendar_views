import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'day_of_month.dart';

/// Class that can generate days of month, including extended days.
@immutable
class MonthViewDaysGenerator {
  MonthViewDaysGenerator({
    @required this.month,
    @required this.firstWeekday,
  })  : assert(month != null),
        assert(firstWeekday != null && isWeekdayValid(firstWeekday));

  final Month month;

  final int firstWeekday;

  List<DayOfMonth> generate() {
    List<DayOfMonth> daysOfMonth = <DayOfMonth>[];

    daysOfMonth.addAll(
      _generateExtendedDaysBefore(),
    );

    daysOfMonth.addAll(
      _generateDaysOfMonth(),
    );

    daysOfMonth.addAll(
      _generateExtendedDaysAfter(),
    );

    return daysOfMonth;
  }

  List<DayOfMonth> _generateExtendedDaysBefore() {
    List<DayOfMonth> extendedDays = <DayOfMonth>[];

    Date firstExtendedDate =
        month.toDateAsFirstDayOfMonth().lowerToWeekday(firstWeekday);

    Date date = firstExtendedDate;
    while (!date.isOfMonth(month)) {
      extendedDays.add(
        _dateToDayOfMonth(date),
      );

      date = date.addDays(1);
    }

    return extendedDays;
  }

  List<DayOfMonth> _generateDaysOfMonth() {
    List<DayOfMonth> daysOfMonth = <DayOfMonth>[];

    Date date = month.toDateAsFirstDayOfMonth();
    while (date.isOfMonth(month)) {
      daysOfMonth.add(
        _dateToDayOfMonth(date),
      );

      date = date.addDays(1);
    }

    return daysOfMonth;
  }

  List<DayOfMonth> _generateExtendedDaysAfter() {
    List<DayOfMonth> extendedDays = <DayOfMonth>[];

    Date lastDateOfMonth = month.toDateAsLastDayOfMonth();

    Date date = lastDateOfMonth.addDays(1);
    while (date.weekday != firstWeekday) {
      extendedDays.add(
        _dateToDayOfMonth(date),
      );

      date = date.addDays(1);
    }

    return extendedDays;
  }

  DayOfMonth _dateToDayOfMonth(Date date) {
    return new DayOfMonth(
      day: date.toDateTime(),
      month: month.toDateTime(),
    );
  }
}

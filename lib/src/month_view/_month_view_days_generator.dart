import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'day_of_month.dart';

/// Class that generates days of month, including extended days.
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
    List<Date> dates = <Date>[];

    dates.addAll(
      _generateExtendedDatesBefore(),
    );

    dates.addAll(
      _generateDatesOfMonth(),
    );

    dates.addAll(
      _generateExtendedDatesAfter(),
    );

    return dates
        .map(
          (date) => _dateToDayOfMonth(date),
        )
        .toList();
  }

  List<Date> _generateExtendedDatesBefore() {
    List<Date> extendedDates = <Date>[];

    Date firstExtendedDate =
        month.toDateAsFirstDayOfMonth().lowerToWeekday(firstWeekday);

    Date date = firstExtendedDate;
    while (!date.isOfMonth(month)) {
      extendedDates.add(date);

      date = date.addDays(1);
    }

    return extendedDates;
  }

  List<Date> _generateDatesOfMonth() {
    List<Date> datesOfMonth = <Date>[];

    Date date = month.toDateAsFirstDayOfMonth();
    while (date.isOfMonth(month)) {
      datesOfMonth.add(date);

      date = date.addDays(1);
    }

    return datesOfMonth;
  }

  List<Date> _generateExtendedDatesAfter() {
    List<Date> extendedDates = <Date>[];

    Date lastDateOfMonth = month.toDateAsLastDayOfMonth();

    Date date = lastDateOfMonth.addDays(1);
    while (date.weekday != firstWeekday) {
      extendedDates.add(date);

      date = date.addDays(1);
    }

    return extendedDates;
  }

  DayOfMonth _dateToDayOfMonth(Date date) {
    return new DayOfMonth(
      day: date.toDateTime(),
      month: month.toDateTime(),
    );
  }
}

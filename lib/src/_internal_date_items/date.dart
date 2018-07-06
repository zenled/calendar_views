import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'month.dart';

/// Internal representation of a date (year.month.day)
/// This class is intended only for use only by this library.
class Date {
  /// Creates a new Date.
  const Date({
    @required this.year,
    @required this.month,
    @required this.day,
  })  : assert(year != null),
        assert(month != null),
        assert(day != null);

  /// Creates new Date from [DateTime].
  factory Date.fromDateTime(DateTime dateTime) {
    return new Date(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  /// Creates new Date that represents today-s date.
  factory Date.today() {
    DateTime now = new DateTime.now();
    return new Date.fromDateTime(
      now,
    );
  }

  /// Year of this Date.
  final int year;

  /// Month of this Date.
  ///
  /// Months are 1-based (1-January, 2-February...).
  final int month;

  /// Day of this Date.
  ///
  /// Days are 1-based (first day of month is 1).
  final int day;

  int get weekday => toDateTime().weekday;

  /// Returns this date as DateTime in local time zone.
  ///
  /// Values except year, month and day are set to 0.
  DateTime toDateTime() {
    return new DateTime(
      year,
      month,
      day,
    );
  }

  /// Returns true if this Date is before some [other] date.
  bool isBefore(Date other) {
    return toDateTime().isBefore(other.toDateTime());
  }

  /// Returns true if this Date is after some [other] date
  bool isAfter(Date other) {
    return toDateTime().isAfter(other.toDateTime());
  }

  /// Returns days between this and some [other] date.
  int daysBetween(Date other) {
    return other.toDateTime().difference(this.toDateTime()).inDays;
  }

  /// Creates a new Date with some values changed.
  Date copyWith({
    int year,
    int month,
    int day,
  }) {
    return new Date(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }

  Date lowerToFirstWeekday(int firstWeekday) {
    Date date = this.copyWith();

    while (date.weekday != firstWeekday) {
      date = date.add(days: -1);
    }

    return date;
  }

  List<Date> daysOfWeek(int firstWeekday) {
    List<Date> daysOfWeek = <Date>[];

    Date firstDay = lowerToFirstWeekday(firstWeekday);
    for (int i = 0; i < DateTime.daysPerWeek; i++) {
      Date day = firstDay.add(days: i);

      daysOfWeek.add(day);
    }

    return daysOfWeek;
  }

  bool isOfMonth(Month month) {
    return this.year == month.year && this.month == month.month;
  }

  /// Returns new Date with some values added.
  Date add({
    int years,
    int months,
    int days,
  }) {
    int year = this.year;
    int month = this.month;
    int day = this.day;

    // adds years
    if (years != null) {
      year += years;
    }

    // adds months
    if (months != null) {
      int monthBase0 = month - 1;

      int yearChange = months ~/ 12;
      int monthChange = (months.abs() % 12) * months.sign;

      year += yearChange;
      int newMonthBase0 = monthBase0 + monthChange;
      if (newMonthBase0 > 11) year++;
      if (newMonthBase0 < 0) year--;
      newMonthBase0 = newMonthBase0 % 12;

      month = newMonthBase0 + 1;
    }

    // adds days
    if (days != null) {
      DateTime dateTimeUTC = new DateTime.utc(year, month, day);

      dateTimeUTC = dateTimeUTC.add(new Duration(days: days));

      year = dateTimeUTC.year;
      month = dateTimeUTC.month;
      day = dateTimeUTC.day;
    }

    return new Date(
      year: year,
      month: month,
      day: day,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Date &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  String toString() {
    return 'Date{$year.$month.$day}';
  }

  @override
  int get hashCode {
    return hash3(year, month, day);
  }
}

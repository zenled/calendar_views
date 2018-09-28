import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'month.dart';
import 'validation.dart';

/// Internal representation of a date (year, month, day).
///
/// This class is intended only for use by this library only.
@immutable
class Date {
  /// Creates a new Date.
  Date(
    this.year,
    this.month,
    this.day,
  )   : assert(year != null),
        assert(month != null && isMonthValid(month)),
        assert(day != null && day >= 1 && day <= 31);

  /// Creates a new Date from [DateTime].
  factory Date.fromDateTime(DateTime dateTime) {
    return new Date(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
  }

  /// Creates a new Date set to today.
  factory Date.today() {
    DateTime now = new DateTime.now();

    return new Date.fromDateTime(now);
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

  /// The day of week this date is on (1-Monday, 2-Tuesday).
  int get weekday => toDateTime().weekday;

  /// Returns true if this date is before [other] date.
  bool isBefore(Date other) {
    return toDateTime().isBefore(other.toDateTime());
  }

  /// Returns true if this date is after [other] date.
  bool isAfter(Date other) {
    return toDateTime().isAfter(other.toDateTime());
  }

  /// Returns true if this date is part of [month].
  bool isOfMonth(Month month) {
    return this.year == month.year && this.month == month.month;
  }

  /// Returns the number of days between this and [other] date.
  int daysBetween(Date other) {
    DateTime thisDateTimeUTC = toDateTimeUTC();
    DateTime otherDateTimeUTC = other.toDateTimeUTC();

    return otherDateTimeUTC.difference(thisDateTimeUTC).inDays;
  }

  /// Returns [Date] that is lowered to the nearest [weekday].
  ///
  /// If this date is already on [weekday] then this date is returned.
  Date lowerToWeekday(int weekday) {
    Date date = this;

    while (date.weekday != weekday) {
      date = date.addDays(-1);
    }

    return date;
  }

  /// Returns a new Date with some days added.
  Date addDays(int days) {
    DateTime dateTimeUTC = toDateTimeUTC();
    dateTimeUTC = dateTimeUTC.add(new Duration(days: days));
    return new Date.fromDateTime(dateTimeUTC);
  }

  /// Creates a new Date with some values changed.
  Date copyWith({
    int year,
    int month,
    int day,
  }) {
    return new Date(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
    );
  }

  /// Returns this date as DateTime in local time zone.
  ///
  /// Values except year, month and day are set to their default values.
  DateTime toDateTime() {
    return new DateTime(year, month, day);
  }

  /// Returns this date as DateTime UTC.
  ///
  /// Values except year, month and day are set to their default values.
  DateTime toDateTimeUTC() {
    return new DateTime.utc(year, month, day);
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

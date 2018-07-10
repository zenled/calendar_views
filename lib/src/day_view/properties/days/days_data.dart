import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/day_view.dart';

/// Data about days that a [DayView] should be displaying.
@immutable
class DaysData {
  /// Creates a new instance of DaysData.
  const DaysData({
    @required this.days,
  }) : assert(days != null);

  /// Creates DaysData when [DayView] should display a single day.
  factory DaysData.forASingleDay({
    @required DateTime day,
  }) {
    return new DaysData(
      days: <DateTime>[day],
    );
  }

  /// List of days that a [DayView] should display.
  final List<DateTime> days;

  /// Number of days that [DayView] should display.
  int get numberOfDays => days.length;

  /// Returns List of integers each one representing sequential number of a single day in [DayView].
  List<int> get dayNumbers {
    List<int> dayNumbers = <int>[];

    for (int i = 0; i < days.length; i++) {
      dayNumbers.add(i);
    }

    return dayNumbers;
  }

  /// Returns day that is represented by a [dayNumber].
  DateTime dayOf(int dayNumber) {
    return days[dayNumber];
  }

  /// Returns how many day separations should be in a [DayView].
  int get numberOfDaySeparations => numberOfDays - 1;

  /// Returns List of integers each one representing sequential number of a single daySeparator in [DayView].
  List<int> get daySeparationNumbers {
    List<int> daySeparationNumbers = <int>[];

    for (int i = 0; i < numberOfDaySeparations; i++) {
      daySeparationNumbers.add(i);
    }

    return daySeparationNumbers;
  }

  /// Returns number of daySeparator that should be shown just before a day with [dayNumber].
  ///
  /// If day does not have a separator before it, it returns null.
  int daySeparatorNumberBefore(int dayNumber) {
    if (dayNumber <= 0 || dayNumber > numberOfDaySeparations) {
      return null;
    } else {
      return dayNumber - 1;
    }
  }

  /// Returns number of daySeparator that should be shown just after a day with [dayNumber].
  ///
  /// If day does not have a separator after it, it returns null.
  int daySeparatorNumberAfter(int dayNumber) {
    if (dayNumber < 0 || dayNumber >= numberOfDaySeparations) {
      return null;
    } else {
      return dayNumber;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaysData &&
          runtimeType == other.runtimeType &&
          days == other.days;

  @override
  int get hashCode => days.hashCode;
}

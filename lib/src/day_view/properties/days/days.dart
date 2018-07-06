import 'package:meta/meta.dart';

import 'package:calendar_views/src/_utils/all.dart' as utils;

/// Item with a list of dates that a DayView is  displaying.
@immutable
class Days {
  const Days({
    @required this.dates,
  }) : assert(dates != null);

  factory Days.forASingleDay({
    @required DateTime date,
  }) {
    return new Days(
      dates: <DateTime>[date],
    );
  }

  final List<DateTime> dates;

  int get numberOfDays => dates.length;

  List<int> get dayNumbers {
    List<int> dayNumbers = <int>[];

    for (int i = 0; i < dates.length; i++) {
      dayNumbers.add(i);
    }

    return dayNumbers;
  }

  int get numberOfDaySeparations => numberOfDays - 1;

  List<int> get daySeparationNumbers {
    List<int> daySeparationNumbers = <int>[];

    for (int i = 0; i < numberOfDaySeparations; i++) {
      daySeparationNumbers.add(i);
    }

    return daySeparationNumbers;
  }

  DateTime getDate(int dayNumber) {
    return dates[dayNumber];
  }

  /// Returns the daySeparationNumber of a separation that belongs to a day with [dayNumber].
  ///
  /// If day does not have a separation it returns null.
  int separationNumberBefore(int dayNumber) {
    if (dayNumber <= 0 || dayNumber > numberOfDaySeparations) {
      return null;
    } else {
      return dayNumber - 1;
    }
  }

  int separationNumberAfter(int dayNumber) {
    if (dayNumber < 0 || dayNumber >= numberOfDaySeparations) {
      return null;
    } else {
      return dayNumber;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Days &&
          runtimeType == other.runtimeType &&
          utils.areListsOfDatesTheSame(dates, other.dates);

  @override
  int get hashCode => dates.hashCode;
}

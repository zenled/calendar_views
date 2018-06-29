import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;

/// Item with a list of dates that a DayView should display.
@immutable
class Dates {
  const Dates({
    @required this.dates,
  }) : assert(dates != null);

  factory Dates.forASingleDay({
    @required DateTime date,
  }) {
    return new Dates(
      dates: <DateTime>[date],
    );
  }

  final List<DateTime> dates;

  int get numberOfDates => dates.length;

  List<int> get dayNumbers {
    List<int> dayNumbers = <int>[];

    for (int i = 0; i < dates.length; i++) {
      dayNumbers.add(i);
    }

    return dayNumbers;
  }

  DateTime getDate(int dayNumber) {
    return dates[dayNumber];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dates &&
          runtimeType == other.runtimeType &&
          utils.areListsOfDatesTheSame(dates, other.dates);

  @override
  int get hashCode => dates.hashCode;
}

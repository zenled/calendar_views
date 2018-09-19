import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

@immutable
class Properties {
  Properties({
    @required this.days,
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 1440,
  })  : assert(days != null),
        assert(minimumMinuteOfDay != null),
        assert(maximumMinuteOfDay != null);

  final List<DateTime> days;
  final int minimumMinuteOfDay;
  final int maximumMinuteOfDay;

  int get numberOfDays => days.length;

  int get numberOfDaySeparations => numberOfDays - 1;

  int get totalNumberOfMinutes => maximumMinuteOfDay - minimumMinuteOfDay;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Properties) {
      return areListsOfDatesTheSame(days, other.days) &&
          minimumMinuteOfDay == other.minimumMinuteOfDay &&
          maximumMinuteOfDay == other.maximumMinuteOfDay;
    } else {
      return false;
    }
  }

  @override
  int get hashCode =>
      days.hashCode ^ minimumMinuteOfDay.hashCode ^ maximumMinuteOfDay.hashCode;
}

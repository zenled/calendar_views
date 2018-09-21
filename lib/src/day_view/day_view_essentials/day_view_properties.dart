import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Class with information that applies to day-view widgets.
@immutable
class DayViewProperties {
  DayViewProperties({
    @required this.days,
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 1440,
  })  : assert(days != null),
        assert(minimumMinuteOfDay != null &&
            isMinuteOfDayValid(minimumMinuteOfDay)),
        assert(maximumMinuteOfDay != null &&
            isMinuteOfDayValid(maximumMinuteOfDay));

  /// List of days for day-view widgets.
  final List<DateTime> days;

  /// Minimum minute of day for day-view widgets.
  final int minimumMinuteOfDay;

  /// Maximum minute of day for day-view widgets.
  final int maximumMinuteOfDay;

  /// Number of days for day-view widgets.
  int get numberOfDays => days.length;

  /// Number of day separations for day-view widgets.
  int get numberOfDaySeparations => numberOfDays - 1;

  /// Number of minutes between [minimumMinuteOfDay] and [maximumMinuteOfDay].
  int get totalNumberOfMinutes => maximumMinuteOfDay - minimumMinuteOfDay;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is DayViewProperties) {
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

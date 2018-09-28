import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Class with information that applies to day view widgets.
@immutable
class DayViewProperties {
  DayViewProperties({
    @required List<DateTime> days,
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 1440,
  })  : assert(days != null),
        this.days = days.map((day) => stripDateInformation(day)).toList(),
        assert(minimumMinuteOfDay != null &&
            isMinuteOfDayValid(minimumMinuteOfDay)),
        assert(maximumMinuteOfDay != null &&
            isMinuteOfDayValid(maximumMinuteOfDay)),
        assert(minimumMinuteOfDay < maximumMinuteOfDay);

  /// List of days for day view widgets.
  final List<DateTime> days;

  /// Minimum minute of day for day view widgets.
  final int minimumMinuteOfDay;

  /// Maximum minute of day for day view widgets.
  final int maximumMinuteOfDay;

  /// Number of minutes between [minimumMinuteOfDay] and [maximumMinuteOfDay].
  int get totalNumberOfMinutes => maximumMinuteOfDay - minimumMinuteOfDay;

  /// Number of days for day view widgets.
  int get numberOfDays => days.length;

  /// Number of day separations for day view widgets.
  int get numberOfDaySeparations => numberOfDays - 1;

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

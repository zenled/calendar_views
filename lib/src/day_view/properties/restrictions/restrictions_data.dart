import 'package:meta/meta.dart';

import 'package:calendar_views/src/_utils/all.dart' as utils;
import 'package:calendar_views/src/day_view/day_view.dart';

/// Data with restrictions placed upon a [DayView].
@immutable
class RestrictionsData {
  static const default_minimumMinuteOfDay = 0;
  static const default_maximumMinuteOfDay = 1440;

  const RestrictionsData({
    this.minimumMinuteOfDay = default_minimumMinuteOfDay,
    this.maximumMinuteOfDay = default_maximumMinuteOfDay,
  })  : assert(minimumMinuteOfDay >= utils.minimum_minute_of_day),
        assert(maximumMinuteOfDay <= utils.maximum_minute_of_day),
        assert(minimumMinuteOfDay <= maximumMinuteOfDay);

  /// Minimum minute of day that a [DayView] is allowed to display (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day that a [DayView] is allowed to display (inclusive).
  final int maximumMinuteOfDay;

  /// Number of minutes that a [DayView] should be able to display.
  int get totalNumberOfMinutes => maximumMinuteOfDay - minimumMinuteOfDay;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestrictionsData &&
          runtimeType == other.runtimeType &&
          minimumMinuteOfDay == other.minimumMinuteOfDay &&
          maximumMinuteOfDay == other.maximumMinuteOfDay;

  @override
  int get hashCode => minimumMinuteOfDay.hashCode ^ maximumMinuteOfDay.hashCode;

  @override
  String toString() {
    return 'Restrictions{minimumMinuteOfDay: $minimumMinuteOfDay, maximumMinuteOfDay: $maximumMinuteOfDay}';
  }
}

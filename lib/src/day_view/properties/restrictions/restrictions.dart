import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;

/// Restrictions placed upon a DayView.
@immutable
class Restrictions {
  static const default_minimumMinuteOfDay = 0;
  static const default_maximumMinuteOfDay = 1440;

  const Restrictions({
    this.minimumMinuteOfDay = default_minimumMinuteOfDay,
    this.maximumMinuteOfDay = default_maximumMinuteOfDay,
  })  : assert(minimumMinuteOfDay >= utils.minimum_minute_of_day),
        assert(maximumMinuteOfDay <= utils.maximum_minute_of_day),
        assert(minimumMinuteOfDay <= maximumMinuteOfDay);

  /// Minimum minute of day that a DayView is allowed to display (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day that a DayView is allowed to display (inclusive).
  final int maximumMinuteOfDay;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restrictions &&
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

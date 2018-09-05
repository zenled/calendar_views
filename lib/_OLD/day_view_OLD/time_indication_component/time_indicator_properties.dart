import 'package:meta/meta.dart';

import 'package:calendar_views/src/_utils/all.dart' as utils;

/// Properties of a TimeIndicator.
///
/// If you use [AtSpecificMinutesTimeIndicatorComponent] and
/// wish to add some custom payload to be delivered to each individual TimeIndicator,
/// you should implement this class and pass your implementation to the component.
@immutable
class TimeIndicatorProperties {
  const TimeIndicatorProperties({
    @required this.minuteOfDay,
    @required this.duration,
  })  : assert(minuteOfDay != null &&
            minuteOfDay >= utils.minimum_minute_of_day &&
            minuteOfDay <= utils.maximum_minute_of_day),
        assert(duration != null && duration >= 0);

  /// Minute of Day at which this TimeIndicator should/will be placed.
  final int minuteOfDay;

  /// Amount of minutes that this timeIndicator covers inside a DayView.
  final int duration;
}

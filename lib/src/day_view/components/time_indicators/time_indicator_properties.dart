import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart';

/// Properties of a TimeIndicator.
@immutable
class TimeIndicatorProperties {
  TimeIndicatorProperties({
    @required this.minuteOfDay,
    @required this.duration,
  })  : assert(minuteOfDay != null && isValidMinuteOfDay(minuteOfDay)),
        assert(duration != null && duration >= 0);

  /// Minute of Day at which this TimeIndicator should/will be placed.
  final int minuteOfDay;

  /// Amount of minutes that this timeIndicator covers inside a DayView.
  final int duration;
}

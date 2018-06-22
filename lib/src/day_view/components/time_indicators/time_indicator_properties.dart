import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart';

@immutable
class TimeIndicatorProperties {
  TimeIndicatorProperties({
    @required this.minuteOfDay,
    @required this.duration,
  })  : assert(minuteOfDay != null && isValidMinuteOfDay(minuteOfDay)),
        assert(duration != null && duration >= 0);

  final int minuteOfDay;

  final int duration;
}

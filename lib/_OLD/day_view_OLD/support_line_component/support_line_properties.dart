import 'package:meta/meta.dart';

import 'package:calendar_views/src/_utils/all.dart' as utils;

@immutable
class SupportLineProperties {
  const SupportLineProperties({
    @required this.minuteOfDay,
  }) : assert(minuteOfDay != null &&
            minuteOfDay >= utils.minimum_minute_of_day &&
            minuteOfDay <= utils.maximum_minute_of_day);

  final int minuteOfDay;
}

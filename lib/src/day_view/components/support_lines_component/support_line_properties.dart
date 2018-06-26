part of support_lines_component;

@immutable
class SupportLineProperties {
  const SupportLineProperties({
    @required this.minuteOfDay,
  }) : assert(minuteOfDay != null &&
            minuteOfDay >= minimum_minute_of_day &&
            minuteOfDay <= maximum_minute_of_day);

  final int minuteOfDay;
}

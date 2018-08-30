import 'package:meta/meta.dart';

@immutable
abstract class TimePositionableItem {
  const TimePositionableItem();

  int get minuteOfDay;
}

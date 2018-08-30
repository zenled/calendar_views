import 'package:meta/meta.dart';

@immutable
abstract class TimePositionableEvent {
  const TimePositionableEvent();

  int get startMinuteOfDay;

  int get duration;
}

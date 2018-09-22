import 'package:meta/meta.dart';

@immutable
abstract class ItemWithStartDuration {
  const ItemWithStartDuration();

  /// Minute of Day at which this TimeIndicator should/will be placed.
  int get startMinuteOfDay;

  /// Amount of minutes that this timeIndicator covers inside a DayView.
  int get duration;
}

import 'package:meta/meta.dart';

@immutable
abstract class ItemWithTime {
  const ItemWithTime();

  int get minuteOfDay;
}

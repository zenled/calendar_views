import 'package:meta/meta.dart';

@immutable
class DaySeparationProperties {
  DaySeparationProperties({
    @required this.daySeparationNumber,
  }) : assert(daySeparationNumber != null);

  final int daySeparationNumber;
}

import 'package:meta/meta.dart';

@immutable
class DayOfMonthProperties {
  DayOfMonthProperties._internal({
    @required this.date,
    @required this.isExtended,
    @required this.month,
  })  : assert(date != null),
        assert(isExtended != null),
        assert(month != null);

  factory DayOfMonthProperties({
    @required DateTime date,
  }) {
    assert(date != null);

    return new DayOfMonthProperties._internal(
      date: date,
      isExtended: false,
      month: new DateTime(date.year, date.month),
    );
  }

  factory DayOfMonthProperties.forExtendedDay({
    @required DateTime date,
    @required DateTime extendedFromMonth,
  }) {
    assert(extendedFromMonth != null);

    return new DayOfMonthProperties._internal(
      date: date,
      isExtended: true,
      month: new DateTime(extendedFromMonth.year, extendedFromMonth.month),
    );
  }

  final DateTime date;

  final bool isExtended;

  final DateTime month;

  bool get isExtendedBefore {
    if (isExtended) {
      return date.isBefore(month);
    } else {
      return false;
    }
  }

  bool get isExtendedAfter {
    if (isExtended) {
      return date.isAfter(month);
    } else {
      return false;
    }
  }
}

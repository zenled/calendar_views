import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

@immutable
class InitialDayValidator {
  InitialDayValidator({
    @required this.initialDay,
    @required this.minimumDay,
    @required this.maximumDay,
  })  : assert(initialDay != null),
        assert(minimumDay != null);

  final Date initialDay;

  final Date minimumDay;
  final Date maximumDay;

  void validate() {
    _validateInRelationToMinimumDay();
    _validateInRelationToMaximumDay();
  }

  void _validateInRelationToMinimumDay() {
    if (initialDay.isBefore(minimumDay)) {
      throw new Exception("initialDay should be on or after minimumDay");
    }
  }

  void _validateInRelationToMaximumDay() {
    if (maximumDay != null) {
      if (initialDay.isAfter(maximumDay)) {
        throw new Exception("initialDay should be on or before maximumDay");
      }
    }
  }
}

import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

class DaysPreparer {
  DaysPreparer({
    @required this.daysPerPage,
    @required this.initialDayCandidate,
    @required this.minimumDayCandidate,
    @required this.maximumDayCandidate,
  })  : assert(daysPerPage != null && daysPerPage > 0),
        assert(initialDayCandidate != null),
        assert(minimumDayCandidate != null),
        assert(maximumDayCandidate != null);

  final int daysPerPage;

  final DateTime initialDayCandidate;
  final DateTime minimumDayCandidate;
  final DateTime maximumDayCandidate;

  Date _initialDay;
  Date _minimumDay;
  Date _maximumDay;

  Date get preparedInitialDay => _initialDay;

  Date get preparedMinimumDay => _minimumDay;

  Date get preparedMaximumDay => _maximumDay;

  /// Prepares initial, minimum and maximum day.
  ///
  /// Throws exception if dayCandidate is invalid.
  void prepare() {
    _convertToDate();
    _validate();
    _adjustToSatisfyDaysPerPage();
  }

  void _convertToDate() {
    _initialDay = new Date.fromDateTime(initialDayCandidate);
    _minimumDay = new Date.fromDateTime(minimumDayCandidate);
    _maximumDay = new Date.fromDateTime(maximumDayCandidate);
  }

  void _validate() {
    _validateMinimumDay();
    _validateMaximumDay();
  }

  void _validateMinimumDay() {
    if (_minimumDay.isAfter(_initialDay)) {
      throw new ArgumentError.value(
        minimumDayCandidate.toString(),
        "minimumDay",
        "minimumDay should be before or same day as initialDay",
      );
    }
  }

  void _validateMaximumDay() {
    if (_maximumDay.isBefore(_initialDay)) {
      throw new ArgumentError.value(
        maximumDayCandidate.toString(),
        "maximumDay",
        "mamumumDay should be after or same day as initialDay",
      );
    }
  }

  void _adjustToSatisfyDaysPerPage() {
    if (daysPerPage != 1) {
      _adjustMinimumDay();
      _adjustMaximumDay();
    }
  }

  void _adjustMinimumDay() {
    while (!(_isFirstDayOfPage(_minimumDay))) {
      _minimumDay = _minimumDay.addDays(-1);
    }
  }

  void _adjustMaximumDay() {
    while (!(_isLastDayOfPage(_maximumDay))) {
      _maximumDay = _maximumDay.addDays(1);
    }
  }

  bool _isFirstDayOfPage(Date day) {
    return _dayOfPage(day) == 0;
  }

  bool _isLastDayOfPage(Date day) {
    return _dayOfPage(day) == daysPerPage - 1;
  }

  int _dayOfPage(Date day) {
    int daysBetween = _initialDay.daysBetween(day);
    daysBetween = daysBetween.abs();

    return daysBetween % daysPerPage;
  }
}

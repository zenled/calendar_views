import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

@deprecated
class DaysPreparer {
  DaysPreparer({
    @required this.defaultPagesDeltaAfterInitialDay,
    @required this.daysPerPage,
    @required this.defaultInitialDay,
    @required this.initialDayCandidate,
    @required this.minimumDayCandidate,
    @required this.maximumDayCandidate,
  })  : assert(defaultPagesDeltaAfterInitialDay != null &&
            defaultPagesDeltaAfterInitialDay > 0),
        assert(daysPerPage != null && daysPerPage > 0),
        assert(defaultInitialDay != null),
        assert(_minimumDay != null);

  final int defaultPagesDeltaAfterInitialDay;
  final int daysPerPage;

  final Date defaultInitialDay;

  final Date initialDayCandidate;
  final Date minimumDayCandidate;
  final Date maximumDayCandidate;

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
    _seyStartingValues();
    _setDefaultsToNullValues();
    _validate();
    _adjustToSatisfyDaysPerPage();
  }

  void _seyStartingValues() {
    _initialDay = initialDayCandidate;
    _minimumDay = minimumDayCandidate;
    _maximumDay = maximumDayCandidate;
  }

  void _setDefaultsToNullValues() {
    if (_initialDay == null) {
      _initialDay = defaultInitialDay;
    }

    if (_maximumDay == null) {
      _maximumDay =
          _initialDay.addDays(defaultPagesDeltaAfterInitialDay * daysPerPage);
    }
  }

  void _validate() {
    _validateInitialDay();
    _validateMaximumDay();
  }

  void _validateInitialDay() {
    if (_minimumDay.isAfter(_initialDay)) {
      throw new ArgumentError.value(
        minimumDayCandidate.toString(),
        "minimumDay",
        "minimumDay($_minimumDay) should be before or same day as initialDay($_initialDay)",
      );
    }
  }

  void _validateMaximumDay() {
    if (_maximumDay.isBefore(_initialDay)) {
      throw new ArgumentError.value(
        maximumDayCandidate.toString(),
        "maximumDay",
        "maximumDay(_$_maximumDay) should be after or same day as initialDay($_initialDay}",
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

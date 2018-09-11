import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/_utils/all.dart';

import '_helpers/all.dart';

@immutable
class DaysConstraints {
  DaysConstraints._internal({
    @required this.daysPerPage,
    @required this.minimumDay,
    this.maximumDay,
  });

  factory DaysConstraints({
    @required int daysPerPage,
    @required DateTime minimumDay,
    DateTime maximumDayCandidate,
  }) {
    // validate daysPerPage
    if (daysPerPage == null) {
      throw new ArgumentError.notNull("daysPerPage");
    }
    if (daysPerPage <= 0) {
      throw new ArgumentError.value(
        daysPerPage,
        "daysPerPage",
        "daysPerPage must be > 0",
      );
    }

    // validate minimumDay
    if (minimumDay == null) {
      throw new ArgumentError.notNull("minimumDay");
    }

    // validate maximumDayCandidate
    if (maximumDayCandidate != null &&
        _isMaximumDayCandidateBeforeMinimumDay(
          minimumDay: minimumDay,
          maximumDayCandidate: maximumDayCandidate,
        )) {
      throw new ArgumentError.value(
        maximumDayCandidate,
        "maximumDayCandidate",
        "maximumDayCandidate should not be before minimumDay",
      );
    }

    // calculate maximumDay
    DateTime maximumDay;
    if (maximumDayCandidate != null) {
      maximumDay = _adjustMaximumDayToSatisfyDaysPerPage(
        daysPerPage: daysPerPage,
        minimumDay: minimumDay,
        maximumDayCandidate: maximumDayCandidate,
      );
    }

    return new DaysConstraints._internal(
      daysPerPage: daysPerPage,
      minimumDay: minimumDay,
      maximumDay: maximumDay,
    );
  }

  factory DaysConstraints.forWeeks({
    int firstWeekday = DateTime.monday,
    @required DateTime dayInMinimumWeek,
    DateTime dayInMaximumWeek,
  }) {
    Date minimumDate = new Date.fromDateTime(dayInMinimumWeek);
    minimumDate = minimumDate.lowerToWeekday(firstWeekday);

    return new DaysConstraints(
      daysPerPage: DateTime.daysPerWeek,
      minimumDay: minimumDate.toDateTime(),
      maximumDayCandidate: dayInMaximumWeek,
    );
  }

  final int daysPerPage;

  final DateTime minimumDay;
  final DateTime maximumDay;

  DaysConstraints copyWithDaysPerPage(int daysPerPage) {
    return new DaysConstraints(
      daysPerPage: daysPerPage,
      minimumDay: minimumDay,
      maximumDayCandidate: maximumDay,
    );
  }

  DaysConstraints copyWithMinimumDay(DateTime minimumDay) {
    return new DaysConstraints(
      daysPerPage: daysPerPage,
      minimumDay: minimumDay,
      maximumDayCandidate: maximumDay,
    );
  }

  DaysConstraints copyWithMaximumDay(DateTime maximumDayCandidate) {
    return new DaysConstraints(
      daysPerPage: daysPerPage,
      minimumDay: minimumDay,
      maximumDayCandidate: maximumDayCandidate,
    );
  }

  @override
  int get hashCode => hash3(daysPerPage, minimumDay, maximumDay);

  @override
  bool operator ==(Object other) {
    if (other is DaysConstraints) {
      return daysPerPage == other.daysPerPage &&
          isSameDate(minimumDay, other.minimumDay) &&
          ((maximumDay == null && other.maximumDay == null) ||
              (isSameDate(maximumDay, other.maximumDay)));
    } else {
      return false;
    }
  }

  static DateTime _adjustMaximumDayToSatisfyDaysPerPage({
    @required int daysPerPage,
    @required DateTime minimumDay,
    @required DateTime maximumDayCandidate,
  }) {
    if (maximumDayCandidate == null) {
      return null;
    } else {
      Date minimumDate = new Date.fromDateTime(minimumDay);
      Date maximumDateCandidate = new Date.fromDateTime(maximumDayCandidate);

      MaximumDateAdjuster maximumDateAdjuster = new MaximumDateAdjuster(
        daysPerPage: daysPerPage,
        minimumDate: minimumDate,
        maximumDateCandidate: maximumDateCandidate,
      );
      return maximumDateAdjuster.adjust().toDateTime();
    }
  }

  static bool _isMaximumDayCandidateBeforeMinimumDay({
    @required DateTime minimumDay,
    @required DateTime maximumDayCandidate,
  }) {
    assert(minimumDay != null);
    assert(maximumDayCandidate != null);

    Date minimumDate = new Date.fromDateTime(minimumDay);
    Date maximumDate = new Date.fromDateTime(maximumDayCandidate);

    return maximumDate.isBefore(minimumDate);
  }
}

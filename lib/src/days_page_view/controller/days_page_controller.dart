import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

import '../days_page_view.dart';

import '_maximum_day_adjuster.dart';

/// Controller for a [DaysPageView].
class DaysPageController extends CalendarPageController<DateTime> {
  DaysPageController._internal({
    @required int daysPerPage,
    @required Date initialDay,
    @required Date minimumDay,
    @required Date maximumDay,
  })  : assert(initialDay != null),
        assert(minimumDay != null),
        _initialDay = initialDay,
        super(
          initialPage: minimumDay.daysBetween(initialDay) ~/ daysPerPage,
          numberOfPages: _calculateNumberOfPages(
            daysPerPage: daysPerPage,
            minimumDay: minimumDay,
            maximumDay: maximumDay,
          ),
        ) {
    _daysPerPage = daysPerPage;

    _minimumDay = minimumDay;
    _maximumDay = maximumDay;
  }

  /// Creates a controller for [DaysPageView].
  ///
  /// If [initialDay] is set to null,
  /// today will be set as [initialDay].
  ///
  /// [minimumDay] will be the lowest day (first day of first page).
  ///
  /// If [maximumDay] is null, the [DaysPageView] will be infinite.
  /// If [maximumDay] is provided it will be automatically increased to satisfy [daysPerPage].
  factory DaysPageController({
    int daysPerPage = 1,
    DateTime initialDay,
    @required DateTime minimumDay,
    DateTime maximumDay,
  }) {
    assert(daysPerPage != null);
    assert(minimumDay != null);

    _throwArgumentErrorIfInvalidDaysPerPage(daysPerPage);

    /// Converts to Date
    Date initial =
        initialDay != null ? Date.fromDateTime(initialDay) : new Date.today();
    Date minimum = Date.fromDateTime(minimumDay);
    Date maximum = maximumDay != null ? Date.fromDateTime(maximumDay) : null;

    /// Validates initialDay
    if (initial.isBefore(minimum)) {
      throw new ArgumentError.value(
        initialDay,
        "initialDay",
        "initialDay($initial) should be after or same day as minimumDay($minimum)",
      );
    }

    /// Validates maximumDay (if provided)
    if (maximum != null) {
      if (maximum.isBefore(initial)) {
        throw new ArgumentError.value(
          maximumDay,
          "maximumDay",
          "maximumDay($maximum) should be after or same day as initialDay($initial}",
        );
      }
    }

    /// Increases maximumDay (if provided) to satisfy daysPerPage
    maximum = _adjustMaximumDayToSatisfyDaysPerPage(
      daysPerPage: daysPerPage,
      minimumDay: minimum,
      maximumDayCandidate: maximum,
    );

    return new DaysPageController._internal(
      daysPerPage: daysPerPage,
      initialDay: initial,
      minimumDay: minimum,
      maximumDay: maximum,
    );
  }

  /// Creates a controller for [DaysPageView] that displays weeks.
  ///
  /// Each week will start with day that is on [firstWeekday].
  ///
  /// Week that contains [dayInInitialWeek],
  /// will be shown when first creating the controlled [DaysPageView].
  ///
  /// If [dayInInitialWeek] is null, it will be set to today.
  ///
  /// Week that contains [dayInMinimumWeek] will be the lowest week.
  ///
  /// If [dayInMaximumWeek] is null, the [DaysPageView] will be infinite.
  factory DaysPageController.forWeeks({
    int firstWeekday = DateTime.monday,
    DateTime dayInInitialWeek,
    @required DateTime dayInMinimumWeek,
    DateTime dayInMaximumWeek,
  }) {
    // lowers dayInMinimumWeek to firstWeekday
    Date minimumCandidate = Date.fromDateTime(dayInMinimumWeek);
    minimumCandidate = minimumCandidate.lowerToWeekday(firstWeekday);
    DateTime minimum = minimumCandidate.toDateTime();

    return new DaysPageController(
      daysPerPage: DateTime.daysPerWeek,
      initialDay: dayInInitialWeek,
      minimumDay: minimum,
      maximumDay: dayInMaximumWeek,
    );
  }

  int _daysPerPage;

  final Date _initialDay;
  Date _minimumDay;
  Date _maximumDay;

  /// Number of consecutive days to display per page.
  int get daysPerPage => _daysPerPage;

  /// Day shown when first creating the controlled [DaysPageView].
  DateTime get initialDay => _initialDay.toDateTime();

  /// Minimum day shown in the controlled [DaysPageView] (inclusive).
  DateTime get minimumDay => _minimumDay.toDateTime();

  /// Maximum day shown in the controlled [DaysPageView] (inclusive), or null if [DaysPageView] is infinite.
  DateTime get maximumDay => isInfinite ? null : _maximumDay.toDateTime();

  /// True if controlled [DaysPageView] is infinite (does not have maximumDay).
  bool get isInfinite => _maximumDay == null;

  @override
  DateTime representationOfCurrentPage() {
    int currentPage = super.displayedPage();
    return _representationOfPage(currentPage);
  }

  @override
  int indexOfPageThatRepresents(DateTime pageRepresentation) {
    return pageOfDay(pageRepresentation);
  }

  DateTime _representationOfPage(int page) {
    return firstDayOfPage(page);
  }

  /// Returns index of page that displays [day].
  ///
  /// If [day] is before [minimumDay], index of first page is returned.
  ///
  /// If [day] is after [maximumDay], index of last page is returned.
  int pageOfDay(DateTime day) {
    Date d = new Date.fromDateTime(day);

    if (d.isBefore(_minimumDay)) {
      return 0;
    }
    if (!isInfinite && d.isAfter(_maximumDay)) {
      return numberOfPages - 1;
    } else {
      int daysFromMinimumDay = _minimumDay.daysBetween(d);
      return daysFromMinimumDay ~/ daysPerPage;
    }
  }

  /// Returns the first day of the set of days displayed on [page].
  ///
  /// Properties of returned day except for year, month and day are set to their default values.
  DateTime firstDayOfPage(int page) {
    assert(page >= 0);

    Date day = _minimumDay.addDays(page * daysPerPage);
    return day.toDateTime();
  }

  /// Returns a list of days displayed on [page].
  ///
  /// Properties of returned days except for year, month and day are set to their default values.
  List<DateTime> daysOfPage(int page) {
    List<DateTime> days = <DateTime>[];

    Date firstDay = new Date.fromDateTime(
      firstDayOfPage(page),
    );

    for (int i = 0; i < daysPerPage; i++) {
      Date day = firstDay.addDays(i);
      days.add(day.toDateTime());
    }

    return days;
  }

  /// Returns a list of days of the current page in the controlled [DaysPageView].
  ///
  /// If no [DaysPageView] is attached it returns null.
  ///
  /// Values of returned [DateTime]s except for year, month and day are set to their default values.
  List<DateTime> displayedDays() {
    int displayedPage = super.displayedPage();

    if (displayedPage != null) {
      return daysOfPage(displayedPage);
    } else {
      return null;
    }
  }

  /// Changes which set of consecutive days is displayed in the controlled [DaysPageView].
  ///
  /// It jumps to page of which [day] is a member of.
  ///
  /// If no [DaysPageView] is attached it does nothing.
  void jumpToDay(DateTime day) {
    int page = pageOfDay(day);

    super.jumpToPage(page);
  }

  /// Animates the controlled [DaysPageView] to the given [day].
  ///
  /// If no [DaysPageView] is attached it does nothing.
  Future<Null> animateToDay(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    int page = pageOfDay(day);

    return super.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  /// Sets the number of consecutive days to display per page.
  ///
  /// If [jumpToDay] is not null the controlled [DaysPageView]
  /// will jump to page of which [jumpToDay] is part of.
  ///
  /// If [jumpToPage] is not null the controller [DaysPageView]
  /// will jump to specified page.
  ///
  /// If both [jumpToDay] and [jumpToPage] are null the controlled [DayPageView]
  /// will jump to page that displays first day of current page.
  void changeDaysPerPage(
    int newDaysPerPage, {
    DateTime jumpToDay,
    int jumpToPage,
  }) {
    _throwArgumentErrorIfInvalidDaysPerPage(newDaysPerPage);

    DateTime representationOfPageToJumpTo;
    if (jumpToDay != null) {
      representationOfPageToJumpTo = jumpToDay;
    } else if (jumpToPage != null) {
      representationOfPageToJumpTo = firstDayOfPage(jumpToPage);
    } else {
      representationOfPageToJumpTo = representationOfCurrentPage();
    }

    _daysPerPage = newDaysPerPage;
    _maximumDay = _adjustMaximumDayToSatisfyDaysPerPage(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDayCandidate: _maximumDay,
    );
    super.numberOfPages = _calculateNumberOfPages(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDay: _maximumDay,
    );

    super.updateControlledItem(representationOfPageToJumpTo);
  }

  void changeMinimumDay(
    DateTime newMinimumDay, {
    DateTime jumpToDay,
    int jumpToPage,
  }) {
    // TODO check in newMinimumDayIsValid

    DateTime representationOfPageToJumpTo;
    if (jumpToDay != null) {
      representationOfPageToJumpTo = jumpToDay;
    } else if (jumpToPage != null) {
      representationOfPageToJumpTo = firstDayOfPage(jumpToPage);
    } else {
      representationOfPageToJumpTo = representationOfCurrentPage();
    }

    _minimumDay = new Date.fromDateTime(newMinimumDay);
    _maximumDay = _adjustMaximumDayToSatisfyDaysPerPage(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDayCandidate: _maximumDay,
    );
    super.numberOfPages = _calculateNumberOfPages(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDay: _maximumDay,
    );

    super.updateControlledItem(representationOfPageToJumpTo);
  }

  void changeMaximumDay(
    DateTime newMaximumDay, {
    DateTime jumpToDay,
    int jumpToPage,
  }) {
    // TODO check in newMaximumDayIsValid

    DateTime representationOfPageToJumpTo;
    if (jumpToDay != null) {
      representationOfPageToJumpTo = jumpToDay;
    } else if (jumpToPage != null) {
      representationOfPageToJumpTo = firstDayOfPage(jumpToPage);
    } else {
      representationOfPageToJumpTo = representationOfCurrentPage();
    }

    _maximumDay = _adjustMaximumDayToSatisfyDaysPerPage(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDayCandidate: new Date.fromDateTime(newMaximumDay),
    );
    super.numberOfPages = _calculateNumberOfPages(
      daysPerPage: daysPerPage,
      minimumDay: _minimumDay,
      maximumDay: _maximumDay,
    );

    super.updateControlledItem(representationOfPageToJumpTo);
  }

  static int _calculateNumberOfPages({
    @required int daysPerPage,
    @required Date minimumDay,
    @required Date maximumDay,
  }) {
    assert(daysPerPage != null);
    assert(minimumDay != null);

    if (maximumDay == null) {
      return null;
    } else {
      return (minimumDay.daysBetween(maximumDay) ~/ daysPerPage) + 1;
    }
  }

  static void _throwArgumentErrorIfInvalidDaysPerPage(int daysPerPage) {
    if (daysPerPage == null) {
      throw new ArgumentError.notNull("daysPerPage");
    }

    if (daysPerPage <= 0) {
      throw new ArgumentError.value(
        daysPerPage,
        "daysPerPage",
        "daysPerPage should be > 0",
      );
    }
  }

  static Date _adjustMaximumDayToSatisfyDaysPerPage({
    @required int daysPerPage,
    @required Date minimumDay,
    @required Date maximumDayCandidate,
  }) {
    if (maximumDayCandidate == null) {
      return null;
    } else {
      MaximumDayAdjuster maximumDayAdjuster = new MaximumDayAdjuster(
        daysPerPage: daysPerPage,
        minimumDay: minimumDay,
        maximumDayCandidate: maximumDayCandidate,
      );
      return maximumDayAdjuster.adjust();
    }
  }
}

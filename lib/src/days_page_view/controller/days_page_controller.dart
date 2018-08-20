import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

import '../days_page_view.dart';

import '_days_preparer.dart';

/// Controller for a [DaysPageView].
class DaysPageController extends CalendarPageController<DateTime> {
  static const default_pagesDeltaFromInitialDay = 1000;

  DaysPageController._internal({
    @required this.daysPerPage,
    @required Date initialDay,
    @required Date minimumDay,
    @required Date maximumDay,
  })  : assert(daysPerPage != null && daysPerPage > 0),
        assert(initialDay != null),
        assert(minimumDay != null),
        assert(maximumDay != null),
        _initialDay = initialDay,
        _minimumDay = minimumDay,
        _maximumDay = maximumDay,
        super(
          initialPage: minimumDay.daysBetween(initialDay) ~/ daysPerPage,
          numberOfPages:
              (minimumDay.daysBetween(maximumDay) ~/ daysPerPage) + 1,
        );

  /// Creates a controller for [DaysPageView].
  ///
  /// If [initialDay] is set to null,
  /// today will be set as [initialDay].
  ///
  /// If [minimumDay] is set to null,
  /// a day [default_pagesDeltaFromInitialDay] before [initialDay] will be set as [minimumDay].
  ///
  /// [minimumDay] is automatically decreased,
  /// to ensure there are always [daysPerPage] days displayed on every page.
  ///
  ///
  /// If [maximumDay] is set to null,
  /// a day [default_pagesDeltaFromInitialDay] after [initialDay] will be set as [maximumDay].
  ///
  /// [maximumDay] is automatically increased,
  /// to ensure there are always [daysPerPage] days displayed on every page.
  factory DaysPageController({
    int daysPerPage = 1,
    DateTime initialDay,
    DateTime minimumDay,
    DateTime maximumDay,
  }) {
    assert(daysPerPage != null);

    /// Validates daysPerPage
    if (daysPerPage <= 0) {
      throw new ArgumentError.value(
        daysPerPage,
        "daysPerPage",
        "daysPerPage must be >= 1",
      );
    }

    DaysPreparer daysPreparer = new DaysPreparer(
      defaultPagesDeltaFromInitialDay: default_pagesDeltaFromInitialDay,
      daysPerPage: daysPerPage,
      defaultInitialDay: new Date.today(),
      initialDayCandidate:
          initialDay != null ? new Date.fromDateTime(initialDay) : null,
      minimumDayCandidate:
          minimumDay != null ? new Date.fromDateTime(minimumDay) : null,
      maximumDayCandidate:
          maximumDay != null ? new Date.fromDateTime(maximumDay) : null,
    );
    daysPreparer.prepare();

    return new DaysPageController._internal(
      daysPerPage: daysPerPage,
      initialDay: daysPreparer.preparedInitialDay,
      minimumDay: daysPreparer.preparedMinimumDay,
      maximumDay: daysPreparer.preparedMaximumDay,
    );
  }

  /// Creates a controller for [DaysPageView] that displays weeks.
  ///
  /// Each week will start with day that is on [firstWeekday].
  ///
  /// Week that contains [dayInsideInitialWeek],
  /// will be shown when first creating the controlled [DaysPageView].
  ///
  /// If [dayInsideInitialWeek] is null, it will be set to today.
  ///
  /// MinimumDay and MaximumDay behave the same as in default constructor.
  factory DaysPageController.forWeeks({
    int firstWeekday = DateTime.monday,
    DateTime dayInsideInitialWeek,
    DateTime minimumDay,
    DateTime maximumDay,
  }) {
    Date initialDate = dayInsideInitialWeek != null
        ? new Date.fromDateTime(dayInsideInitialWeek)
        : new Date.today();

    initialDate = initialDate.lowerToWeekday(firstWeekday);

    return new DaysPageController(
      daysPerPage: DateTime.daysPerWeek,
      initialDay: initialDate.toDateTime(),
      minimumDay: minimumDay,
      maximumDay: maximumDay,
    );
  }

  /// Number of consecutive days displayed per page.
  final int daysPerPage;

  final Date _initialDay;
  final Date _minimumDay;
  final Date _maximumDay;

  /// Day shown when first creating the controlled [DaysPageView].
  DateTime get initialDay => _initialDay.toDateTime();

  /// Minimum day shown in the controlled [DaysPageView] (inclusive).
  DateTime get minimumDay => _minimumDay.toDateTime();

  /// Maximum day shown in the controlled [DaysPageView] (inclusive).
  DateTime get maximumDay => _maximumDay.toDateTime();

  @override
  DateTime representationOfCurrentPage() {
    return firstDayOnDisplayedPage();
  }

  @override
  int indexOfPageThatRepresents(DateTime pageRepresentation) {
    return pageOfDay(pageRepresentation);
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
    if (d.isAfter(_maximumDay)) {
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
    int pagesDeltaFromInitialPage = page - initialPage;

    Date day = _initialDay.addDays(pagesDeltaFromInitialPage * daysPerPage);

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

  /// Returns the first day of days displayed on the current page in the controlled [DaysPageView].
  ///
  /// If no [DaysPageView] is attached an exception is thrown.
  ///
  /// Properties of returned [DateTime]s except for year, month and day are set to their default values.
  DateTime firstDayOnDisplayedPage() {
    int displayedPage = super.displayedPage();
    return firstDayOfPage(displayedPage);
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

  /// Creates a copy of the controller with some values changed.
  ///
  /// Any items attached to the original controller are not copied.
  DaysPageController copyWith({
    int daysPerPage,
    DateTime minimumDay,
    DateTime maximumDay,
  }) {
    return new DaysPageController(
      daysPerPage: daysPerPage ?? this.daysPerPage,
      initialDay: this.initialDay,
      minimumDay: minimumDay ?? this.minimumDay,
      maximumDay: maximumDay ?? this.maximumDay,
    );
  }
}

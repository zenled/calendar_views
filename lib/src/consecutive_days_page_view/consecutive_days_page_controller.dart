import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_items/all.dart';

import 'consecutive_days_page_view.dart';

/// Controller for a [ConsecutiveDaysPageView].
class ConsecutiveDaysPageController extends CalendarPageController<DateTime> {
  static const default_pagesDeltaFromInitialDay = 1000;

  ConsecutiveDaysPageController._internal({
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

  /// Creates a controller for [ConsecutiveDaysPageView].
  ///
  /// Default value for [daysPerPage] is [DateTime.daysPerWeek] (7, a day for every day of week).
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
  /// a week [default_pagesDeltaFromInitialDay] after [initialDay] will be set as [maximumDay].
  ///
  /// [maximumDay] is automatically increased,
  /// to ensure there are always [daysPerPage] days displayed on every page.
  factory ConsecutiveDaysPageController({
    int daysPerPage = DateTime.daysPerWeek,
    DateTime initialDay,
    DateTime minimumDay,
    DateTime maximumDay,
  }) {
    assert(daysPerPage != null && daysPerPage > 0);

    // Converts to internal representation of weeks
    Date initial;
    Date minimum;
    Date maximum;

    if (initialDay != null) {
      initial = new Date.fromDateTime(initialDay);
    } else {
      initial = new Date.today();
    }

    if (minimumDay != null) {
      minimum = new Date.fromDateTime(minimumDay);

      if (daysPerPage != 1) {
        // lowers minimum so there is always [daysPerPage] days displayed on each page.
        while (minimum.daysBetween(initial) % daysPerPage == 0) {
          minimum = minimum.add(days: -1);
        }
      }
    } else {
      minimum = initial.add(
        days: -(default_pagesDeltaFromInitialDay * daysPerPage),
      );
    }

    if (maximumDay != null) {
      maximum = new Date.fromDateTime(maximumDay);

      if (daysPerPage != 1) {
        // increases maximum so there is always [daysPerPage] days displayed on each page.
        while (maximum.daysBetween(initial) % daysPerPage == 0) {
          maximum = maximum.add(days: -1);
        }
      }
    } else {
      maximum = initial.add(
        days: (default_pagesDeltaFromInitialDay * daysPerPage),
      );
    }

    // Validates
    if (!(minimum.isBefore(initial) || minimum == initial)) {
      throw new ArgumentError(
        "minimumDay should be before or same day as initialDay",
      );
    }
    if (!(maximum.isAfter(initial) || maximum == initial)) {
      throw new ArgumentError(
        "mamumumDay should be after or same day as initialDay",
      );
    }

    return new ConsecutiveDaysPageController._internal(
      daysPerPage: daysPerPage,
      initialDay: initial,
      minimumDay: minimum,
      maximumDay: maximum,
    );
  }

  /// Number of consecutive days displayed per page.
  final int daysPerPage;

  final Date _initialDay;
  final Date _minimumDay;
  final Date _maximumDay;

  /// Day shown when first creating the controlled [ConsecutiveDaysPageView].
  DateTime get initialDay => _initialDay.toDateTime();

  /// Minimum day shown in the controlled [ConsecutiveDaysPageView] (inclusive).
  DateTime get minimumDay => _minimumDay.toDateTime();

  /// Maximum day shown in the controlled [ConsecutiveDaysPageView] (inclusive).
  DateTime get maximumDay => _maximumDay.toDateTime();

  @override
  DateTime representationOfCurrentPage() {
    return displayedFirstDay();
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
    }

    int daysFromMinimumDay = _minimumDay.daysBetween(d);
    return daysFromMinimumDay ~/ daysPerPage;
  }

  /// Returns the first day in the list of days displayed on [page].
  ///
  /// Values of returned day except for year, month and day are set to their default values.
  DateTime firstDayOfPage(int page) {
    int pagesDeltaFromInitialPage = page - initialPage;

    Date day = _initialDay.add(
      days: (pagesDeltaFromInitialPage * daysPerPage),
    );

    return day.toDateTime();
  }

  /// Returns a list of days displayed on [page].
  ///
  /// Values of returned days except for year, month and day are set to their default values.
  List<DateTime> daysOfPage(int page) {
    List<DateTime> days = <DateTime>[];

    Date firstDay = new Date.fromDateTime(
      firstDayOfPage(page),
    );

    for (int i = 0; i < daysPerPage; i++) {
      days.add(
        firstDay.add(days: i).toDateTime(),
      );
    }

    return days;
  }

  /// Returns the first day of days displayed on the current page in the controlled [ConsecutiveDaysPageView].
  ///
  /// If no [ConsecutiveDaysPageView] is attached it returns null.
  ///
  /// Values of returned [DateTime]s except for year, month and day are set to their default values.
  DateTime displayedFirstDay() {
    int displayedPage = super.displayedPage();

    if (displayedPage != null) {
      return firstDayOfPage(displayedPage);
    } else {
      return null;
    }
  }

  /// Returns a list of days of the current page in the controlled [ConsecutiveDaysPageView].
  ///
  /// If no [ConsecutiveDaysPageView] is attached it returns null.
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

  /// Changes which set of consecutive days is displayed in the controlled [ConsecutiveDaysPageView].
  ///
  /// It jumps to page of which [day] is a member of.
  ///
  /// If no [ConsecutiveDaysPageView] is attached it does nothing.
  void jumpToDay(DateTime day) {
    int page = pageOfDay(day);

    super.jumpToPage(page);
  }

  /// Animates the controlled [ConsecutiveDaysPageView] to the given [day].
  ///
  /// If no [ConsecutiveDaysPageView] is attached it does nothing.
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
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_items/all.dart';
import 'package:calendar_views/src/_utils/all.dart' as utils;

import 'week_page_view.dart';

/// Controller for a [WeekPageView].
class WeekPageController extends CalendarPageController<DateTime> {
  static const default_weeksDeltaFromInitialWeek = 1000;

  WeekPageController._internal({
    @required this.firstWeekday,
    @required Date initialWeek,
    @required Date minimumWeek,
    @required Date maximumWeek,
  })  : assert(firstWeekday != null && utils.isValidWeekday(firstWeekday)),
        assert(initialWeek != null),
        assert(minimumWeek != null),
        assert(maximumWeek != null),
        _initialWeek = initialWeek,
        _minimumWeek = minimumWeek,
        _maximumWeek = maximumWeek,
        super(
          initialPage: utils.weeksBetween(minimumWeek, initialWeek),
          numberOfPages: utils.weeksBetween(minimumWeek, maximumWeek) + 1,
        );

  /// Creates a controller for [WeekPageView].
  ///
  /// Default value for [firstWeekday] is Monday.
  ///
  /// If [initialWeek] is set to null,
  /// today-week will be set as [initialWeek].
  ///
  /// If [minimumWeek] is set to null,
  /// a week [default_weeksDeltaFromInitialWeek] before [initialWeek] will be set as [minimumWeek].
  ///
  ///
  /// If [maximumWeek] is set to null,
  /// a week [default_weeksDeltaFromInitialWeek] after [initialWeek] will be set as [maximumWeek].
  factory WeekPageController({
    int firstWeekday = DateTime.monday,
    DateTime initialWeek,
    DateTime minimumWeek,
    DateTime maximumWeek,
  }) {
    assert(firstWeekday != null);

    // Converts to internal representation of weeks
    Date initial;
    Date minimum;
    Date maximum;

    if (initialWeek != null) {
      initial = utils.dateTimeToWeek(firstWeekday, initialWeek);
    } else {
      initial = utils.dateTimeToWeek(firstWeekday, new DateTime.now());
    }

    if (minimumWeek != null) {
      minimum = utils.dateTimeToWeek(firstWeekday, minimumWeek);
    } else {
      minimum = initial.add(
        days: -(default_weeksDeltaFromInitialWeek * DateTime.daysPerWeek),
      );
    }

    if (maximumWeek != null) {
      maximum = utils.dateTimeToWeek(firstWeekday, maximumWeek);
    } else {
      maximum = initial.add(
        days: (default_weeksDeltaFromInitialWeek * DateTime.daysPerWeek),
      );
    }

    // Validates
    if (!(minimum.isBefore(initial) || minimum == initial)) {
      throw new ArgumentError(
        "minimumWeek should be before or same week as initialWeek",
      );
    }
    if (!(maximum.isAfter(initial) || maximum == initial)) {
      throw new ArgumentError(
        "maximumWeek should be before or same month as initialWeek",
      );
    }

    return new WeekPageController._internal(
      firstWeekday: firstWeekday,
      initialWeek: initial,
      minimumWeek: minimum,
      maximumWeek: maximum,
    );
  }

  /// Day of week of first day in the displayed week.
  final int firstWeekday;

  final Date _initialWeek;
  final Date _minimumWeek;
  final Date _maximumWeek;

  /// Week shown when first creating the controlled [WeekPageView].
  DateTime get initialWeek => _initialWeek.toDateTime();

  /// Minimum week shown in the controlled [WeekPageView] (inclusive).
  DateTime get minimumWeek => _minimumWeek.toDateTime();

  /// Maximum week shown in the controlled [WeekPageView] (inclusive).
  DateTime get maximumWeek => _maximumWeek.toDateTime();

  @override
  DateTime representationOfCurrentPage() {
    return displayedWeek();
  }

  @override
  int indexOfPageThatRepresents(DateTime pageRepresentation) {
    return pageOfWeek(pageRepresentation);
  }

  /// Returns index of page that displays [week].
  ///
  /// If [week] is before [minimumWeek], index of first page is returned.
  ///
  /// If [week] is after [maximumWeek], index of last page is returned.
  int pageOfWeek(DateTime week) {
    Date w = utils.dateTimeToWeek(firstWeekday, week);

    if (w.isBefore(_minimumWeek)) {
      return 0;
    }
    if (w.isAfter(_maximumWeek)) {
      return numberOfPages - 1;
    }
    return utils.weeksBetween(_minimumWeek, w);
  }

  /// Returns a list of days displayed on [page].
  ///
  /// Values of returned days except for year, month and day are set to their default values.
  List<DateTime> daysOfPage(int page) {
    DateTime week = weekOfPage(page);

    Date w = utils.dateTimeToWeek(firstWeekday, week);

    return w
        .daysOfWeek(firstWeekday)
        .map(
          (date) => date.toDateTime(),
        )
        .toList();
  }

  /// Returns the first day in the set of days displayed on [page].
  ///
  /// Values of returned day except for year, month and day are set to their default values.
  DateTime weekOfPage(int page) {
    int deltaFromInitialPage = page - initialPage;

    Date week = _initialWeek.add(
      days: (deltaFromInitialPage * DateTime.daysPerWeek),
    );

    return week.toDateTime();
  }

  /// Returns currently displayed days of week in the controlled [WeekPageView].
  ///
  /// If no [WeekPageView] is attached it returns null.
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

  /// Returns the first day of the set of days that are currently displayed in the controlled [WeekPageView].
  ///
  /// If no [WeekPageView] is attached it returns null.
  ///
  /// Values of returned [DateTime]s except for year, month and day are set to their default values.
  DateTime displayedWeek() {
    int displayedPage = super.displayedPage();

    if (displayedPage != null) {
      return weekOfPage(displayedPage);
    } else {
      return null;
    }
  }

  /// Changes which [week] is displayed in the controlled [WeekPageView].
  ///
  /// If no [WeekPageView] is attached it does nothing.
  void jumpToWeek(DateTime week) {
    int page = pageOfWeek(week);

    super.jumpToPage(page);
  }

  /// Animates the controlled [WeekPageView] to the given [week].
  ///
  /// If no [WeekPageView] is attached it does nothing.
  Future<Null> animateToWeek(
    DateTime week, {
    @required Duration duration,
    @required Curve curve,
  }) {
    int page = pageOfWeek(week);

    return super.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }
}

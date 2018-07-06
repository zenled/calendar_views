import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_items/all.dart';

import 'day_page_view.dart';

/// Controller for [DayPageView].
class DayPageController extends CalendarPageController<DateTime> {
  static const default_daysDeltaFromInitialDate = 10000;

  DayPageController._internal({
    @required Date initialDay,
    @required Date minimumDay,
    @required Date maximumDay,
  })  : assert(initialDay != null),
        assert(minimumDay != null),
        assert(maximumDay != null),
        _initialDay = initialDay,
        _minimumDay = minimumDay,
        _maximumDay = maximumDay,
        super(
          initialPage: minimumDay.daysBetween(initialDay),
          numberOfPages: minimumDay.daysBetween(maximumDay) + 1,
        );

  /// Creates a controller for [DayPageView].
  ///
  /// If [initialDay] is set to null,
  /// today will be set as [initialDay].
  ///
  /// If [minimumDay] is set to null,
  /// a day [default_daysDeltaFromInitialDate] before [initialDay] will be set as [minimumDay].
  ///
  ///
  /// If [maximumDay] is set to null,
  /// a day [default_daysDeltaFromInitialDate] after [initialDay] will be set as [maximumDay].
  factory DayPageController({
    DateTime initialDay,
    DateTime minimumDay,
    DateTime maximumDay,
  }) {
    // Converts to internal representation of date
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
    } else {
      minimum = initial.add(days: -default_daysDeltaFromInitialDate);
    }

    if (maximumDay != null) {
      maximum = new Date.fromDateTime(maximumDay);
    } else {
      maximum = initial.add(days: default_daysDeltaFromInitialDate);
    }

    // validates
    if (!(minimum.isBefore(initial) || minimum == initial)) {
      throw new ArgumentError(
        "minimumDate should be before or same date as initialDate.",
      );
    }
    if (!(maximum.isAfter(initial) || maximum == initial)) {
      throw new ArgumentError(
        "maximumDate should be after or same date as initialDate.",
      );
    }

    return new DayPageController._internal(
      initialDay: initial,
      minimumDay: minimum,
      maximumDay: maximum,
    );
  }

  final Date _initialDay;
  final Date _minimumDay;
  final Date _maximumDay;

  /// Day shown when first creating the controlled [DayPageView].
  DateTime get initialDay => _initialDay.toDateTime();

  /// Minimum day shown in the controlled [DayPageView] (inclusive).
  DateTime get minimumDay => _minimumDay.toDateTime();

  /// Maximum day shown in the controlled [DayPageView] (inclusive).
  DateTime get maximumDay => _maximumDay.toDateTime();

  @override
  DateTime representationOfCurrentPage() {
    return displayedDay();
  }

  @override
  int indexOfPageThatRepresents(DateTime pageRepresentation) {
    return pageOf(pageRepresentation);
  }

  /// Returns index of page that displays [day].
  ///
  /// If [day] is before [minimumDay], index of first page is returned.
  ///
  /// If [day] is after [maximumDay], index of last page is returned.
  int pageOf(DateTime day) {
    Date d = new Date.fromDateTime(day);

    if (d.isBefore(_minimumDay)) {
      return 0;
    }
    if (d.isAfter(_maximumDay)) {
      return numberOfPages - 1;
    }
    return _minimumDay.daysBetween(d);
  }

  /// Returns day displayed on [page].
  ///
  /// Values of returned day except year and month and day are set to their default values.
  DateTime dayOf(int page) {
    int deltaFromInitialPage = page - initialPage;

    return _initialDay.add(days: deltaFromInitialPage).toDateTime();
  }

  /// Returns currently displayed day in the controlled [DayPageView].
  ///
  /// If no [DayPageView] is attached it returns null.
  ///
  /// Values of returned [DateTime] except for year, month and day are set to their default values.
  DateTime displayedDay() {
    int displayedPage = super.displayedPage();

    if (displayedPage == null) {
      return null;
    } else {
      return dayOf(displayedPage);
    }
  }

  /// Changes which [day] is displayed in the controlled [DayPageView].
  ///
  /// If no [DayPageView] is attached it does nothing.
  void jumpTo(DateTime day) {
    int pageOfDay = pageOf(day);

    super.jumpToPage(pageOfDay);
  }

  /// Animates the controlled [DayPageView] to the given [day].
  ///
  /// If no [DayPageView] is attached it does nothing.
  void animateTo(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    int pageOfDay = pageOf(day);

    super.animateToPage(
      pageOfDay,
      duration: duration,
      curve: curve,
    );
  }
}

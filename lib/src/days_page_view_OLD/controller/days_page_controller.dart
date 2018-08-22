import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

import '../days_page_view.dart';
import '../communicator.dart';

import '_page_days.dart';
import '_page_days_validator.dart';
import '_initial_day_validator.dart';

class DaysPageController {
  DaysPageController({
    @required this.initialDay,
  }) : assert(initialDay != null);

  final DateTime initialDay;

  Communicator _attachedItem;

  void attach(Communicator communicator) {
    _attachedItem = communicator;
  }

  void detach() {
    _attachedItem = null;
  }

  void jumpToDay(DateTime day) {
    _attachedItem.jumpToDay;
  }
}

/// Controller for a [DaysPageViewOLD].
class DaysPageControllerOLD extends CalendarPageController<DateTime> {
  DaysPageControllerOLD._internal({
    @required Date initialDay,
    @required PageDays pageDays,
  })  : assert(initialDay != null),
        assert(pageDays != null),
        _initialDay = initialDay,
        _pageDays = pageDays,
        super(
          initialPage: pageDays.pageOfDay(initialDay),
          numberOfPages: pageDays.numberOfPages,
        ) {
    PageDaysValidator pageDaysValidator = new PageDaysValidator(
      pageDays: pageDays,
    );
    pageDaysValidator.validate();

    InitialDayValidator initialDayValidator = new InitialDayValidator(
      initialDay: initialDay,
      minimumDay: pageDays.minimumDay,
      maximumDay: pageDays.maximumDay,
    );
    initialDayValidator.validate();
  }

  /// Creates a controller for [DaysPageViewOLD].
  ///
  /// If [initialDay] is null,
  /// today will be set as [initialDay].
  ///
  /// [minimumDay] will be the lowest day (first day of first page).
  ///
  /// If [maximumDay] is null, the [DaysPageViewOLD] will be infinite.
  /// If [maximumDay] is provided it will be automatically increased to satisfy [daysPerPage].
  factory DaysPageControllerOLD({
    int daysPerPage = 1,
    DateTime initialDay,
    @required DateTime minimumDay,
    DateTime maximumDay,
  }) {
    assert(daysPerPage != null);
    assert(minimumDay != null);

    // converts to Date
    Date initial;
    Date minimum;
    Date maximumCandidate;

    initial =
        initialDay != null ? Date.fromDateTime(initialDay) : new Date.today();
    minimum = Date.fromDateTime(minimumDay);
    maximumCandidate =
        maximumDay != null ? Date.fromDateTime(maximumDay) : null;

    // creates pageDays
    PageDays pageDays = new PageDays(
      daysPerPage: daysPerPage,
      minimumDay: minimum,
      maximumDayCandidate: maximumCandidate,
    );

    return new DaysPageControllerOLD._internal(
      initialDay: initial,
      pageDays: pageDays,
    );
  }

  /// Creates a controller for [DaysPageViewOLD] that displays weeks.
  ///
  /// Each week will start with day that is on [firstWeekday].
  ///
  /// Week that contains [dayInInitialWeek],
  /// will be shown when first creating the controlled [DaysPageViewOLD].
  ///
  /// If [dayInInitialWeek] is null, it will be set to today.
  ///
  /// Week that contains [dayInMinimumWeek] will be the lowest week.
  ///
  /// If [dayInMaximumWeek] is null, the controlled [DaysPageViewOLD] will be infinite.
  factory DaysPageControllerOLD.forWeeks({
    int firstWeekday = DateTime.monday,
    DateTime dayInInitialWeek,
    @required DateTime dayInMinimumWeek,
    DateTime dayInMaximumWeek,
  }) {
    // lowers dayInMinimumWeek to firstWeekday
    Date minimumCandidate = Date.fromDateTime(dayInMinimumWeek);
    minimumCandidate = minimumCandidate.lowerToWeekday(firstWeekday);
    DateTime minimum = minimumCandidate.toDateTime();

    return new DaysPageControllerOLD(
      daysPerPage: DateTime.daysPerWeek,
      initialDay: dayInInitialWeek,
      minimumDay: minimum,
      maximumDay: dayInMaximumWeek,
    );
  }

  final Date _initialDay;

  PageDays _pageDays;

  /// Number of consecutive days to display per page.
  int get daysPerPage => _pageDays.daysPerPage;

  /// Day shown when first creating the controlled [DaysPageViewOLD].
  DateTime get initialDay => _initialDay.toDateTime();

  /// Minimum day shown in the controlled [DaysPageViewOLD] (inclusive).
  DateTime get minimumDay => _pageDays.minimumDay.toDateTime();

  /// Maximum day shown in the controlled [DaysPageViewOLD] (inclusive), or null if [DaysPageViewOLD] is infinite.
  DateTime get maximumDay =>
      _pageDays.isInfinite ? null : _pageDays.maximumDay.toDateTime();

  /// True if controlled [DaysPageViewOLD] is infinite (does not have maximumDay).
  bool get isInfinite => _pageDays.isInfinite;

  @override
  DateTime representationOfCurrentPage() {
    int currentPage = super.displayedPage();
    return _representationOfPage(currentPage);
  }

  @override
  int indexOfPageThatRepresents(DateTime pageRepresentation) {
    return _pageOfRepresentation(
      new Date.fromDateTime(pageRepresentation),
    );
  }

  DateTime _representationOfPage(int page) {
    return _pageDays.getFirstDayOfPage(page).toDateTime();
  }

  int _pageOfRepresentation(Date representation) {
    return _pageDays.pageOfDay(representation);
  }

  /// Returns a list of days displayed on [page].
  ///
  /// Properties of returned days except for year, month and day are set to their default values.
  List<DateTime> daysOfPage(int page) {
    return _pageDays.daysOfPage(page).map((date) => date.toDateTime()).toList();
  }

  /// Returns a list of days of the current page in the controlled [DaysPageViewOLD].
  ///
  /// Properties of returned days except for year, month and day are set to their default values.
  List<DateTime> displayedDays() {
    int currentPage = super.displayedPage();

    return daysOfPage(currentPage);
  }

  /// Changes the controlled [DaysPageViewOLD] to the given [day].
  void jumpToDay(DateTime day) {
    int page = _pageOfRepresentation(new Date.fromDateTime(day));
    super.jumpToPage(page);
  }

  /// Animates the controlled [DaysPageViewOLD] to the given [day].
  Future<Null> animateToDay(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    int page = _pageOfRepresentation(new Date.fromDateTime(day));
    return super.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  /// Changes the number of days displayed per page in the controlled [DaysPageViewOLD].
  void changeDaysPerPage(int daysPerPage) {
    DateTime currentPageRepresentation;
    if (super.isCommunicatorAttached()) {
      currentPageRepresentation = representationOfCurrentPage();
    }

    _pageDays = new PageDays(
      daysPerPage: daysPerPage,
      minimumDay: _pageDays.minimumDay,
      maximumDayCandidate: _pageDays.maximumDay,
    );
    super.numberOfPages = _pageDays.numberOfPages;

    if (super.isCommunicatorAttached()) {
      super.updateControlledItem(currentPageRepresentation);
    }
  }

  /// Changes the minimumDay in the controlled [DaysPageViewOLD].
  void changeMinimumDay(DateTime minimumDay) {
    DateTime currentPageRepresentation;
    if (super.isCommunicatorAttached()) {
      currentPageRepresentation = representationOfCurrentPage();
    }

    _pageDays = new PageDays(
      daysPerPage: _pageDays.daysPerPage,
      minimumDay: new Date.fromDateTime(minimumDay),
      maximumDayCandidate: _pageDays.maximumDay,
    );
    super.numberOfPages = _pageDays.numberOfPages;

    if (super.isCommunicatorAttached()) {
      super.updateControlledItem(currentPageRepresentation);
    }
  }

  /// Changes the maximumDay in the controlled [DaysPageViewOLD].
  void changeMaximumDay(DateTime maximumDay) {
    DateTime currentPageRepresentation;
    if (super.isCommunicatorAttached()) {
      currentPageRepresentation = representationOfCurrentPage();
    }

    _pageDays = new PageDays(
      daysPerPage: _pageDays.daysPerPage,
      minimumDay: _pageDays.minimumDay,
      maximumDayCandidate: new Date.fromDateTime(maximumDay),
    );
    super.numberOfPages = _pageDays.numberOfPages;

    if (super.isCommunicatorAttached()) {
      super.updateControlledItem(currentPageRepresentation);
    }
  }
}

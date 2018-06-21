import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/internal_date_items/all.dart';

import 'day_pager_position.dart';

/// Controller for [DayPager].
class DayPagerController {
  static const _default_daysDelta_from_initialDate = 10000;

  /// Creates a controller for [DayPager], with all values required.
  DayPagerController.raw({
    @required DateTime initialDate,
    @required DateTime minimumDate,
    @required DateTime maximumDate,
  })  : assert(initialDate != null),
        assert(minimumDate != null),
        assert(maximumDate != null),
        this._initialDate = new Date.fromDateTime(initialDate),
        this._minimumDate = new Date.fromDateTime(minimumDate),
        this._maximumDate = new Date.fromDateTime(maximumDate) {
    // validates minimum date
    if (!(_minimumDate.isBefore(_initialDate) ||
        _minimumDate == _initialDate)) {
      throw new ArgumentError(
        "MinimumDate should be before or same date as InitialDate.",
      );
    }

    // validates maximum date
    if (!(_maximumDate.isAfter(_initialDate) || _maximumDate == _initialDate)) {
      throw new ArgumentError(
        "MaximumDate should be afrer or same date as InitialDate.",
      );
    }

    // sets other properties
    _initialPage = _minimumDate.daysBetween(_initialDate);
    _numberOfPages = _minimumDate.daysBetween(_maximumDate) + 1;
  }

  /// Creates a controller for [DayPager].
  ///
  /// Both [minimumDate] and [maximumDate] are inclusive.
  ///
  /// If [initialDate] is not provided, it will be set to today's date.
  ///
  /// If [minimumDate] is not provided, the controlled [DayPager]
  /// will be virtually infinite in the direction before [initialDate].
  ///
  /// If [maximumDate] is not provided, the controlled [DayPager]
  /// will be virtually infinite in the direction after [initialDate].
  factory DayPagerController({
    DateTime initialDate,
    DateTime minimumDate,
    DateTime maximumDate,
  }) {
    initialDate ??= new DateTime.now();

    if (minimumDate == null) {
      minimumDate = initialDate.add(
        new Duration(days: -_default_daysDelta_from_initialDate),
      );
    }

    if (maximumDate == null) {
      maximumDate = initialDate.add(
        new Duration(days: _default_daysDelta_from_initialDate),
      );
    }

    return new DayPagerController.raw(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    );
  }

  final Date _minimumDate;

  final Date _maximumDate;

  final Date _initialDate;

  int _initialPage;

  int _numberOfPages;

  /// Connector for controlling the attached pager.
  DayPagerPosition _pagerPosition;

  /// Minimum date that the attached pager should display (inclusive).
  DateTime get minimumDate => _maximumDate.toDateTime();

  /// Maximum date that the attached pager should display (inclusive).
  DateTime get maximumDate => _maximumDate.toDateTime();

  /// Date which the attached pager should display when first built.
  DateTime get initialDate => _initialDate.toDateTime();

  /// Index of the initial page that the attached pager should display.
  int get initialPage => _initialPage;

  /// Number of pages that the attached pager should be able to display.
  int get numberOfPages => _numberOfPages;

  /// Returns displayed date (page) in the attached [DayPager].
  ///
  /// If no [DayPager] is attached it returns null.
  DateTime get displayedDate {
    if (_pagerPosition == null) {
      return null;
    } else {
      return dateOf(_pagerPosition.getDisplayedPage());
    }
  }

  /// Returns page (page index) that represents a [date] in the attached [DayPager].
  ///
  /// If [date] if before [minimumDate], first page is returned.
  /// If [date] is after [maximumDate], last page is returned.
  int pageOf(DateTime date) {
    Date d = new Date.fromDateTime(date);

    if (d.isBefore(_minimumDate)) {
      return 0;
    }
    if (d.isAfter(_maximumDate)) {
      return numberOfPages - 1;
    }
    return _minimumDate.daysBetween(d);
  }

  /// Returns date that should be displayed on specified [page] (page index) in the attached [DayPager].
  DateTime dateOf(int page) {
    int deltaFromInitialPage = page - initialPage;

    return _initialDate
        .add(
          days: deltaFromInitialPage,
        )
        .toDateTime();
  }

  /// Registers the given [DayPagerPosition] with the controller.
  ///
  /// If a previous [DayPagerPosition] is registered, it is replaced with the new one.
  void attach(DayPagerPosition pagerPosition) {
    _pagerPosition = pagerPosition;
  }

  /// Unregisters the previously attached [DayPagerPosition].
  void detach() {
    _pagerPosition = null;
  }

  /// Forces the attached [DayPager] to jump to specified [date].
  void jumpTo(DateTime date) {
    if (_pagerPosition == null) {
      print("No DayPager attached");
      return;
    }

    _pagerPosition.jumpToPage(
      pageOf(date),
    );
  }

  /// Forces the attached [DayPager] to animate to specified [date].
  void animateTo(
    DateTime date, {
    @required Duration duration,
    @required Curve curve,
  }) {
    if (_pagerPosition == null) {
      print("No DayPager attached");
      return;
    }

    _pagerPosition.animateToPage(
      pageOf(date),
      duration: duration,
      curve: curve,
    );
  }
}

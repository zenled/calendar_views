import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'days_page_link.dart';
import 'days_page_view.dart';

/// Controller for [DaysPageView].
class DaysPageController extends CalendarPageController {
  /// Creates a new [DaysPageController].
  ///
  /// If [firstDayOnInitialPage] is null, it is set to whatever day is today.
  DaysPageController({
    DateTime firstDayOnInitialPage,
    this.daysPerPage = DateTime.daysPerWeek,
  })  : this.firstDayOfInitialPage =
            firstDayOnInitialPage ?? new DateTime.now(),
        assert(firstDayOnInitialPage != null),
        assert(daysPerPage != null && daysPerPage > 0);

  /// Day to display as first day on initial page when first creating [DaysPageView].
  final DateTime firstDayOfInitialPage;

  /// Number of days to display on a page in [DaysPageView].
  ///
  /// If [DaysPageView] is given a controller with different [daysPerPage] than the initial one,
  /// the number of days displayed per page will not change.
  final int daysPerPage;

  DaysPageLink _attachedItem;

  @override
  DaysPageLink get attachedItem => _attachedItem;

  void attach(DaysPageLink communicator) {
    _attachedItem = communicator;
  }

  void detach() {
    _attachedItem = null;
  }

  /// Returns the current days displayed in the attached [DaysPageView].
  ///
  /// Properties of returned days except for year, month and day are set to their default values.
  ///
  /// If nothing is attached to this controller it throws an exception.
  List<DateTime> currentDays() {
    throwExceptionIfNoItemAttached();

    return attachedItem.currentDays();
  }

  /// Tels the controlled [DaysPageView] to jump to the given [day].
  ///
  /// Works similar as [PageController.jumpToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  void jumpToDay(DateTime day) {
    throwExceptionIfNoItemAttached();

    attachedItem.jumpToDay(day);
  }

  /// Tels the controlled [DaysPageView] to animate to the given [day].
  ///
  /// Works similar as [PageController.animateToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  Future<void> animateToDay(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    throwExceptionIfNoItemAttached();

    return _attachedItem.animateToDay(
      day,
      duration: duration,
      curve: curve,
    );
  }
}

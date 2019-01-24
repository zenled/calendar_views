import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'month_page_link.dart';
import 'month_page_view.dart';

/// Controller for [MonthPageView].
class MonthPageController extends CalendarPageController {
  /// Creates a new [MonthPageController].
  ///
  /// If [initialMonth] is null, it is set to whatever month is today.
  MonthPageController({
    DateTime initialMonth,
  })  : this.initialMonth = initialMonth ?? new DateTime.now(),
        assert(initialMonth != null);

  /// Month to display when first creating [MonthPageView].
  final DateTime initialMonth;

  MonthPageLink _attachedItem;

  @override
  MonthPageLink get attachedItem => _attachedItem;

  /// Attaches an item to this controller.
  ///
  /// If a previous item is attached it is replaced with the new one.
  void attach(MonthPageLink link) {
    _attachedItem = link;
  }

  /// Detaches the previously attached item.
  void detach() {
    _attachedItem = null;
  }

  /// Returns the current month displayed in the attached [MonthPageView].
  ///
  /// Properties of returned month except for year and month are set to their default values.
  ///
  /// If nothing is attached to this controller it throws an exception.
  DateTime get currentMonth {
    throwExceptionIfNoItemAttached();

    return attachedItem.currentMonth();
  }

  /// Tels the controlled [MonthPageView] to jump to the given [month].
  ///
  /// Works similar as [PageController.jumpToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  void jumpToMonth(DateTime month) {
    throwExceptionIfNoItemAttached();

    attachedItem.jumpToMonth(month);
  }

  /// Tels the controlled [MonthPageView] to animate to the given [month].
  ///
  /// Works similar as [PageController.animateToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  Future<void> animateToMonth(
    DateTime month, {
    @required Duration duration,
    @required Curve curve,
  }) {
    throwExceptionIfNoItemAttached();

    return attachedItem.animateToMonth(
      month,
      duration: duration,
      curve: curve,
    );
  }
}

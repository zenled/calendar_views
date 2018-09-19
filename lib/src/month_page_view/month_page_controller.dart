import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/custom_page_view/all.dart';

import 'month_page_communicator.dart';
import 'month_page_view.dart';

/// Controller for a [MonthPageView].
class MonthPageController extends CustomPageViewController {
  MonthPageController._internal({
    @required this.initialMonth,
  });

  /// Creates a new [MonthPageController].
  ///
  /// If [initialMonth] is null it is set to whatever month is today.
  factory MonthPageController({
    DateTime initialMonth,
  }) {
    initialMonth ??= new DateTime.now();

    return new MonthPageController._internal(
      initialMonth: initialMonth,
    );
  }

  /// Month to be displayed when first creating [MonthPageView].
  final DateTime initialMonth;

  MonthPageCommunicator attachedItem;

  /// Attaches [communicator] to this controller.
  ///
  /// If a previous communicator is attached it is replaced with the new one.
  void attach(MonthPageCommunicator communicator) {
    attachedItem = communicator;
  }

  /// Detaches the previously attached communicator.
  void detach() {
    attachedItem = null;
  }

  /// Returns the current month displayed in the attached [MonthPageView].
  ///
  /// If no [MonthPageView] is attached it throws an exception.
  ///
  /// Properties of month except for year and month are set to their default values.
  DateTime get currentMonth {
    throwExceptionIfNoItemAttached();

    return attachedItem.currentMonth();
  }

  /// Tells the attached [MonthPageView] to jump to a specific month.
  ///
  /// If no [MonthPageView] is attached it throws an exception.
  void jumpToMonth(DateTime month) {
    throwExceptionIfNoItemAttached();

    attachedItem.jumpToMonth(month);
  }

  /// Tells the attached [MonthPageView] to animate to a specific month.
  ///
  /// If no [MonthPageView] is attached it throws an exception.
  Future<Null> animateToMonth(
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

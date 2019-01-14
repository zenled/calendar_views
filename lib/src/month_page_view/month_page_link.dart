import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'month_page_controller.dart';
import 'month_page_view.dart';

/// Signature for a function that changes which month is displayed in the [MonthPageView].
///
/// Works similar as [PageController.jumpToPage].
typedef void JumpToMonthCallback(
  DateTime month,
);

/// Signature for a function that animates [MonthPageView] to the given month.
///
/// Works similar as [PageController.animateToPage].
typedef Future<void> AnimateToMonthCallback(
  DateTime month, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [MonthPageView] and [MonthPageController].
@immutable
class MonthPageLink extends CalendarPageLink {
  MonthPageLink({
    @required this.currentMonth,
    @required this.jumpToMonth,
    @required this.animateToMonth,
    @required ValueGetter<int> currentPage,
    @required JumpToPageCallback jumpToPage,
    @required AnimateToPageCallback animateToPage,
  })  : assert(currentMonth != null),
        assert(jumpToMonth != null),
        assert(animateToMonth != null),
        super(
          currentPage: currentPage,
          jumpToPage: jumpToPage,
          animateToPage: animateToPage,
        );

  final ValueGetter<DateTime> currentMonth;

  final JumpToMonthCallback jumpToMonth;
  final AnimateToMonthCallback animateToMonth;
}

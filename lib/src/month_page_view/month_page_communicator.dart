import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/custom_page_view/all.dart';

import 'month_page_view.dart';
import 'month_page_controller.dart';

/// Signature for a function that tells [MonthPageView] to jump to specific month.
typedef void JumpToMonthCallback(
  DateTime month,
);

/// Signature for a function that tells [MonthPageView] to animate to specific month.
typedef Future<Null> AnimateToMonthCallback(
  DateTime month, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [MonthPageView] and [MonthPageController].
@immutable
class MonthPageCommunicator extends CustomPageViewCommunicator {
  MonthPageCommunicator({
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

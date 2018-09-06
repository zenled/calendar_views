import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/month_page_view.dart';

typedef void JumpToMonthCallback(
  DateTime month,
);

typedef Future<Null> AnimateToMonthCallback(
  DateTime month, {
  @required Duration duration,
  @required Curve curve,
});

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

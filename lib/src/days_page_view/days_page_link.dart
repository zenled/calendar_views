import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'days_page_controller.dart';
import 'days_page_view.dart';

/// Signature for a function that changes which group of days is displayed in [DaysPageView].
///
/// Works similar as [PageController.jumpToPage].
typedef void JumpToDayCallback(
  DateTime day,
);

/// Signature for a function that animates [DaysPageView] to the given day.
///
/// Works similar as [PageController.animateToPage].
typedef Future<void> AnimateToDayCallback(
  DateTime day, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [DaysPageView] and [DaysPageController].
@immutable
class DaysPageLink extends CalendarPageLink {
  DaysPageLink({
    @required this.currentDays,
    @required this.jumpToDay,
    @required this.animateToDay,
    @required ValueGetter<int> currentPage,
    @required JumpToPageCallback jumpToPage,
    @required AnimateToPageCallback animateToPage,
  })  : assert(currentDays != null),
        assert(jumpToDay != null),
        assert(animateToDay != null),
        super(
          currentPage: currentPage,
          jumpToPage: jumpToPage,
          animateToPage: animateToPage,
        );

  final ValueGetter<List<DateTime>> currentDays;

  final JumpToDayCallback jumpToDay;
  final AnimateToDayCallback animateToDay;
}

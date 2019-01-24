import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_page_controller.dart';
import 'calendar_page_view.dart';

/// Signature for a function that changes which page is displayed in the [CalendarPageView].
///
/// Works similar as [PageController.jumpToPage].
typedef void JumpToPageCallback(
  int page,
);

/// Signature for a function that animates [CalendarPageView] to the given page.
///
/// Works similar as [PageController.animateToPage].
typedef Future<void> AnimateToPageCallback(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Base class for a communicator between [CalendarPageView] and [CalendarPageController].
@immutable
abstract class CalendarPageLink {
  const CalendarPageLink({
    @required this.currentPage,
    @required this.jumpToPage,
    @required this.animateToPage,
  })  : assert(currentPage != null),
        assert(jumpToPage != null),
        assert(animateToPage != null);

  final ValueGetter<int> currentPage;

  final JumpToPageCallback jumpToPage;
  final AnimateToPageCallback animateToPage;
}

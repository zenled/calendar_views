import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_page_controller.dart';

typedef void JumpToPage(int page);

typedef Future<Null> AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between a calendar-PageView and [CalendarPageController].
@immutable
class CalendarPageViewCommunicator {
  CalendarPageViewCommunicator({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.displayedPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(displayedPage != null);

  /// Tells calendar-PageView to jump to a specific [page].
  final JumpToPage jumpToPage;

  /// Tells calendar-PageView to animate to a specified [page].
  final AnimateToPage animateToPage;

  /// Requests the current displayed page from the calendar-PageView.
  final ValueGetter<int> displayedPage;
}

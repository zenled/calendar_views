import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_page_controller.dart';
import 'calendar_page_view.dart';

typedef void JumpToPage(int page);

typedef Future<Null> AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

typedef void OnControllerChanged(
  dynamic representationOfCurrentPage,
);

/// Communicator between a [CalendarPageView] and [CalendarPageController].
@immutable
class CalendarPageViewCommunicator {
  CalendarPageViewCommunicator({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.displayedPage,
    @required this.onControllerChanged,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(displayedPage != null),
        assert(onControllerChanged != null);

  /// Tells [CalendarPageView] to jump to a specific [page].
  final JumpToPage jumpToPage;

  /// Tells [CalendarPageView] to animate to a specified [page].
  final AnimateToPage animateToPage;

  /// Requests the current displayed page from the controlled [CalendarPageView].
  final ValueGetter<int> displayedPage;

  /// Called whenever number of pages changes.
  final OnControllerChanged onControllerChanged;
}

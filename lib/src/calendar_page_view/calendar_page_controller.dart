import 'dart:async';

import 'package:flutter/material.dart';

import 'calendar_page_link.dart';
import 'calendar_page_view.dart';

/// Base class for a controller for [CalendarPageView].
abstract class CalendarPageController {
  const CalendarPageController();

  /// Returns the item attached to this controller.
  @protected
  CalendarPageLink get attachedItem;



  /// Returns the current page displayed in the attached [CalendarPageView].
  ///
  /// If nothing is attached to this controller it throws an exception.
  int get currentPage {

    return attachedItem.currentPage();
  }

  /// Tels the controlled [CalendarPageView] to jump to the given [page].
  ///
  /// Works similar as [PageController.jumpToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  void jumpToPage(int page) {

    attachedItem.jumpToPage(page);
  }

  /// Tels the controlled [CalendarPageView] to animate to the given [page].
  ///
  /// Works similar as [PageController.animateToPage].
  ///
  /// If nothing is attached to this controller it throws an exception.
  Future<void> animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
  }) {

    return attachedItem.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

}

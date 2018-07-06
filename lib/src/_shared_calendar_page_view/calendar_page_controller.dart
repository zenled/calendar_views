import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_page_view_communicator.dart';

/// Base class for a custom (Calendar) PageController.
abstract class CalendarPageController {
  CalendarPageViewCommunicator _attachedCommunicator;

  /// Registers the given [communicator] with this controller.
  ///
  /// If any prior communicators are attached, they are replaced with the new [communicator].
  void attach(CalendarPageViewCommunicator communicator) {
    _attachedCommunicator = communicator;
  }

  /// Unregisters the previously attached communicator.
  void detach() {
    _attachedCommunicator = null;
  }

  /// Returns true if there is a [CalendarPageViewCommunicator] attached to this controller.
  bool isCalendarPageViewAttached() {
    return _attachedCommunicator != null;
  }

  /// Returns displayed page in the controlled calendar-PageView.
  ///
  /// If no item is attached it returns null.
  int displayedPage() {
    if (isCalendarPageViewAttached()) {
      return _attachedCommunicator.displayedPage();
    } else {
      return null;
    }
  }

  /// Changes which [page] is displayed in the controlled calendar-PageView.
  ///
  /// If no item is attached it does nothing.
  void jumpToPage(int page) {
    if (isCalendarPageViewAttached()) {
      _attachedCommunicator.jumpToPage(page);
    }
  }

  /// Animates the controlled calendar-PageView to the given [page].
  ///
  /// If no item is attached it does nothing.
  Future<Null> animateToPage(
    int page, {
    @required Duration duration,
    @required Curve curve,
  }) {
    if (isCalendarPageViewAttached()) {
      return _attachedCommunicator.animateToPage(
        page,
        duration: duration,
        curve: curve,
      );
    } else {
      return null;
    }
  }
}

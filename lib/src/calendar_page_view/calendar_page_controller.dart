import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_page_view_communicator.dart';
import 'calendar_page_view.dart';

/// Base class of a controller for a [CalendarPageView].
///
/// Each page of the controlled [CalendarPageView] should be representable
/// with an unique object of type [T].
abstract class CalendarPageController<T> {
  CalendarPageController({
    @required this.initialPage,
    @required this.numberOfPages,
  })  : assert(initialPage != null),
        assert(numberOfPages != null),
        assert(initialPage >= 0 && initialPage < numberOfPages);

  /// Initial page that the controlled [CalendarPageView] should display.
  final int initialPage;

  /// Number of pages that the controlled [CalendarPageView] should be able to display.
  final int numberOfPages;

  /// Object for communication with attached [CalendarPageView].
  CalendarPageViewCommunicator _attachedCommunicator;

  /// Registers the given [communicator] with this controller.
  ///
  /// If a communicators is already attached, it is replaced with the new one.
  void attach(CalendarPageViewCommunicator communicator) {
    _attachedCommunicator = communicator;
  }

  /// Unregisters the previously attached communicator.
  void detach() {
    _attachedCommunicator = null;
  }

  /// Returns true if there is a [CalendarPageView] attached to this controller.
  bool isCommunicatorAttached() {
    return _attachedCommunicator != null;
  }

  /// Returns currently displayed page in the controlled [CalendarPageView].
  ///
  /// If no [CalendarPageView] is attached it returns null.
  int displayedPage() {
    _throwExceptionIfNoCommunicatorIsAttached();

    return _attachedCommunicator.displayedPage();
  }

  /// Returns a representation of current page in the controlled [CalendarPageView].
  ///
  /// If no [CalendarPageView] is attached it returns null.
  T representationOfCurrentPage();

  /// Returns index of page that displays [pageRepresentation].
  ///
  /// If none of the pages displays [pageRepresentation] it returns index of page that is closest to desired page.
  int indexOfPageThatRepresents(T pageRepresentation);

  /// Changes which [page] is displayed in the controlled [CalendarPageView].
  ///
  /// If no [CalendarPageView] is attached it does nothing.
  void jumpToPage(int page) {
    if (isCommunicatorAttached()) {
      _attachedCommunicator.jumpToPage(page);
    }
  }

  /// Animates the controlled [CalendarPageView] to the given [page].
  ///
  /// If no [CalendarPageView] is attached it does nothing.
  Future<Null> animateToPage(
    int page, {
    @required Duration duration,
    @required Curve curve,
  }) {
    if (isCommunicatorAttached()) {
      return _attachedCommunicator.animateToPage(
        page,
        duration: duration,
        curve: curve,
      );
    } else {
      return null;
    }
  }

  void _throwExceptionIfNoCommunicatorIsAttached() {
    if (!isCommunicatorAttached()) {
      throw new Exception("No item is attached to this controller");
    }
  }
}

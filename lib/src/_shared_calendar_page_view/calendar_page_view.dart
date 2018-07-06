import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_calendar_page_view_communicator.dart';
import 'calendar_page_controller.dart';

/// Base class for for a pageView that can be controlled with [CalendarPageController].
abstract class CalendarPageView extends StatefulWidget {
  CalendarPageView({
    @required this.scrollDirection,
    @required this.reverse,
    @required this.physics,
    @required this.pageSnapping,
  })  : assert(scrollDirection != null),
        assert(reverse != null),
        assert(pageSnapping != null);

  /// Same as [PageView.scrollDirection].
  final Axis scrollDirection;

  /// Same as [PageView.reverse].
  final bool reverse;

  /// Same as [PageView.physics].
  final ScrollPhysics physics;

  /// Same as [PageView.pageSnapping].
  final bool pageSnapping;

  /// Returns object that is in charge of controlling this [CalendarPageView].
  CalendarPageController get controller;
}

abstract class CalendarPageViewState<T extends CalendarPageView>
    extends State<T> {
  PageView _pageView;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController(
      initialPage: widget.controller.initialPage,
    );

    _pageView = _createPageView();

    _attachToController();
  }

  @override
  void dispose() {
    widget.controller?.detach();

    super.dispose();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.scrollDirection != oldWidget.scrollDirection ||
        widget.reverse != oldWidget.reverse ||
        widget.physics != oldWidget.physics ||
        widget.pageSnapping != oldWidget.pageSnapping ||
        hasAnythingChanged(oldWidget)) {
      dynamic representationOfCurrentPage =
          oldWidget.controller.representationOfCurrentPage();

      int initialPageOnNewPageController;

      if (representationOfCurrentPage != null) {
        initialPageOnNewPageController = widget.controller
            .indexOfPageThatRepresents(representationOfCurrentPage);
      } else {
        initialPageOnNewPageController = widget.controller.initialPage;
      }

      _pageController = _createPageController(
        initialPage: initialPageOnNewPageController,
      );

      oldWidget.controller.detach();
      _attachToController();

      onPageChanged(initialPageOnNewPageController);

      setState(() {
        _pageView = _createPageView();
      });
    }
  }

  /// Returns true if this.widget is different from [oldWidget].
  ///
  /// Only properties of this (not super) should be checked.
  bool hasAnythingChanged(T oldWidget);

  PageController _createPageController({
    @required int initialPage,
  }) {
    assert(initialPage != null);

    return new PageController(
      initialPage: initialPage,
    );
  }

  PageView _createPageView() {
    return new PageView.builder(
      controller: _pageController,
      itemCount: widget.controller.numberOfPages,
      itemBuilder: pageBuilder,
      onPageChanged: onPageChanged,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      physics: widget.physics,
      pageSnapping: widget.pageSnapping,
      key: new UniqueKey(),
    );
  }

  void _attachToController() {
    widget.controller.attach(
      _createCalendarPageViewCommunicator(),
    );
  }

  CalendarPageViewCommunicator _createCalendarPageViewCommunicator() {
    return new CalendarPageViewCommunicator(
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
      displayedPage: () {
        return _pageController.page.round();
      },
    );
  }

  Widget pageBuilder(BuildContext context, int page);

  void onPageChanged(int page);

  @override
  Widget build(BuildContext context) {
    return _pageView;
  }
}

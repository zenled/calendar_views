import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_calendar_page_view_communicator.dart';
import 'calendar_page_controller.dart';

/// Base class for for a pageView that can be controlled with [CalendarPageController].
///
/// Internally this is a wrapper around a [PageView],
/// so behaviour and properties might sometimes be similar.
///
/// **Important**
///
/// The working of this widget is a bodge.
/// I could not find another way to keep the same page
/// (eg. same date, not just page number as does [PageView]),
/// when changing properties of internal [PageView].
/// There might also be a bug in [PageView] that prevents it from correctly changing scrollDirection at runtime
/// [bug issue](https://github.com/flutter/flutter/issues/16481).
/// I tried to make a workaround.
///
/// Due to this workaround
/// state of all pages will be lost if [controller] or [scrollDirection] is changed at runtime.
/// State will be lost even when using [PageStorage] or [AutomaticKeepAliveClientMixin]
/// or similar state-storing solutions.
/// This is because internally an entirely new (with new State) [PageView]
/// is created when changing those properties.
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

  Key _keyOfPageView;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController(
      initialPage: widget.controller.initialPage,
    );

    _pageView = _createPageView(
      withUniqueKey: false,
    );

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

      bool createPageViewWithUniqueKey =
          widget.scrollDirection != oldWidget.scrollDirection ||
              widget.controller != oldWidget.controller;

      setState(() {
        _pageView = _createPageView(
          withUniqueKey: createPageViewWithUniqueKey,
        );
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

  PageView _createPageView({
    @required bool withUniqueKey,
  }) {
    if (withUniqueKey || _keyOfPageView == null) {
      _keyOfPageView = new UniqueKey();
    }

    return new PageView.builder(
      controller: _pageController,
      itemCount: widget.controller.numberOfPages,
      itemBuilder: pageBuilder,
      onPageChanged: onPageChanged,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      physics: widget.physics,
      pageSnapping: widget.pageSnapping,
      key: _keyOfPageView,
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

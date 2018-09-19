import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Base class for a custom page view where each page is given a representation.
///
/// [CalendarPageView] has virtually infinite number of pages.
abstract class CalendarPageView extends StatefulWidget {
  static const default_scroll_direction = Axis.horizontal;
  static const default_page_snapping = true;
  static const default_reverse = false;
  static const ScrollPhysics default_physics = null;

  CalendarPageView({
    this.scrollDirection = default_scroll_direction,
    this.pageSnapping = default_page_snapping,
    this.reverse = default_reverse,
    this.physics = default_physics,
  })  : assert(scrollDirection != null),
        assert(pageSnapping != null),
        assert(reverse != null);

  final Axis scrollDirection;
  final bool pageSnapping;
  final bool reverse;
  final ScrollPhysics physics;

  @override
  CalendarPageViewState createState();
}

/// Base class for a [CalendarPageView] state.
///
/// Each page in [CalendarPageViewState] is given an object of type [REPRESENTATION].
abstract class CalendarPageViewState<WIDGET extends CalendarPageView,
    REPRESENTATION> extends State<WIDGET> {
  static const initial_page = 100000;

  @protected
  PageController pageController;

  /// Returns representation of [page].
  @protected
  REPRESENTATION getRepresentationOfPage(int page);

  /// Returns page of [representation].
  @protected
  int getPageOfRepresentation(REPRESENTATION representation);

  @override
  void initState() {
    super.initState();

    pageController = new PageController(
      initialPage: initial_page,
    );
  }

  void _onPageChanged(int page) {
    REPRESENTATION representation = getRepresentationOfPage(page);
    onRepresentationChanged(representation);
  }

  /// Called whenever the current page and thus the representation changes.
  @protected
  onRepresentationChanged(REPRESENTATION representation);

  /// Returns currently displayed page.
  @protected
  int getCurrentPage() {
    return pageController.page.round();
  }

  /// Jumps to the given page.
  @protected
  void jumpToPage(int page) {
    pageController.jumpToPage(page);
  }

  /// Animates to the given page.
  @protected
  Future<Null> animateToPage(
    int page, {
    @required Duration duration,
    @required Curve curve,
  }) {
    return pageController.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      scrollDirection: widget.scrollDirection,
      pageSnapping: widget.pageSnapping,
      reverse: widget.reverse,
      physics: widget.physics,
      onPageChanged: _onPageChanged,
      controller: pageController,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int page) {
    REPRESENTATION representation = getRepresentationOfPage(page);

    return itemBuilder(context, representation);
  }

  /// Builds a page in the [CalendarPageView].
  @protected
  Widget itemBuilder(BuildContext context, REPRESENTATION representation);
}

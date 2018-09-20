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
abstract class CalendarPageViewState<WIDGET extends CalendarPageView>
    extends State<WIDGET> {
  static const initial_page = 100000;

  @protected
  PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = new PageController(
      initialPage: initial_page,
    );
  }

  @protected
  void onPageChanged(int page);

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
      onPageChanged: onPageChanged,
      controller: pageController,
      itemBuilder: itemBuilder,
    );
  }

  @protected
  Widget itemBuilder(BuildContext context, int page);
}

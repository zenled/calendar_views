import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Base class for a custom page view.
///
/// Each page in a [CustomPageView] needs an unique representation of type [T].
abstract class CustomPageView<T> extends StatefulWidget {
  static const default_scroll_direction = Axis.horizontal;
  static const default_page_snapping = true;
  static const default_reverse = false;
  static const ScrollPhysics default_physics = null;

  CustomPageView({
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
  CustomPageViewState createState();
}

/// Base class for a [CustomPageView] state.
abstract class CustomPageViewState<WIDGET extends CustomPageView,
    REPRESENTATION_TYPE> extends State<WIDGET> {
  static const initial_page = 100;

  bool _isActive;

  bool allowOnPageChanged = true;

  @protected
  PageController pageController;

  /// Representation of the currently displayed page.
  @protected
  REPRESENTATION_TYPE currentRepresentation;

  /// Returns representation of [page].
  @protected
  REPRESENTATION_TYPE getRepresentationOfPage(int page);

  /// Returns page that represents [representation].
  @protected
  int getPageOfRepresentation(REPRESENTATION_TYPE representation);

  /// The total number of pages to display.
  ///
  /// Return null if infinite number of pages.
  @protected
  int get numberOfPages;

  /// Page to show when first creating this widget.
  @protected
  int get initialPage;

  /// Returns currently displayed page.
  @protected
  int get currentPage => pageController.page.round();

  @override
  void initState() {
    super.initState();

    _isActive = true;
  }

  @override
  void dispose() {
    _isActive = false;

    super.dispose();
  }

  void _initPageControllerAndCurrentRepresentationIfNecessary() {
    if (pageController == null) {
      pageController = new PageController(
        initialPage: initialPage,
        keepPage: false,
      );

      currentRepresentation = getRepresentationOfPage(initialPage);
    }
  }

  void _onPageChanged(int page) {
    if (allowOnPageChanged) {
      currentRepresentation = getRepresentationOfPage(page);
    }
    allowOnPageChanged = true;

    onPageChanged(currentRepresentation);
  }

  /// Called whenever the current page changes.
  @protected
  onPageChanged(REPRESENTATION_TYPE representationOfPage);

  void _scheduleOnAfterBuild() {
    new Future.delayed(Duration.zero, _onAfterBuild);
  }

  Future<void> _onAfterBuild() async {
    if (!_isActive) {
      return;
    }

    REPRESENTATION_TYPE displayedRepresentation =
        getRepresentationOfPage(currentPage);

    if (!areRepresentationsTheSame(
      currentRepresentation,
      displayedRepresentation,
    )) {
      allowOnPageChanged = false;
      int pageToJumpTo = getPageOfRepresentation(currentRepresentation);
      pageController.jumpToPage(pageToJumpTo);
    }
  }

  /// Returns true if [representation1] and [representation2] represent the same thing.
  bool areRepresentationsTheSame(
    REPRESENTATION_TYPE representation1,
    REPRESENTATION_TYPE representation2,
  );

  @protected
  void jumpToPage(int page) {
    pageController.jumpToPage(page);
  }

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
    _initPageControllerAndCurrentRepresentationIfNecessary();
    _scheduleOnAfterBuild();

    return new PageView.custom(
      controller: pageController,
      scrollDirection: widget.scrollDirection,
      pageSnapping: widget.pageSnapping,
      reverse: widget.reverse,
      physics: widget.physics,
      onPageChanged: _onPageChanged,
      childrenDelegate: new _BoundedSliverChildBuilderDelegate(
        builder: _itemBuilder,
        minPage: 0,
        maxPage: 5,
      ),
    );

//    return new PageView.builder(
//      itemBuilder: _itemBuilder,
//      itemCount: numberOfPages,
//    );
  }

  Widget _itemBuilder(BuildContext context, int page) {
    REPRESENTATION_TYPE representation = getRepresentationOfPage(page);

    return itemBuilder(context, representation);
  }

  /// Builds a page in [CustomPageView].
  @protected
  Widget itemBuilder(BuildContext context, REPRESENTATION_TYPE representation);
}

class _BoundedSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  _BoundedSliverChildBuilderDelegate({
    @required IndexedWidgetBuilder builder,
    @required this.minPage,
    @required this.maxPage,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : super(
          builder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        );

  final int minPage;
  final int maxPage;

  @override
  Widget build(BuildContext context, int index) {
    if (index < minPage || (childCount != null && index > maxPage)) {
      return null;
    }

    Widget child = builder(context, index);
    if (child == null) {
      return null;
    }
    if (addRepaintBoundaries) {
      child = RepaintBoundary.wrap(child, index);
    }
    if (addAutomaticKeepAlives) {
      child = AutomaticKeepAlive(child: child);
    }
    return child;
  }

  @override
  int get estimatedChildCount => maxPage - minPage;
}

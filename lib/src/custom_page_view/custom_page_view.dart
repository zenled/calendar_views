import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Base class for a custom page view.
abstract class CustomPageView extends StatefulWidget {
  static const default_scroll_direction = Axis.horizontal;
  static const default_page_snapping = true;
  static const default_reverse = false;

  CustomPageView({
    this.scrollDirection = default_scroll_direction,
    this.pageSnapping = default_page_snapping,
    this.reverse = default_reverse,
  });

  final Axis scrollDirection;
  final bool pageSnapping;
  final bool reverse;
}

abstract class CustomPageViewState extends State<CustomPageView> {
  @protected
  PageController pageController;

  @protected
  Key pageViewKey;

  @protected
  int get numberOfPages;

  @protected
  void createPageController({
    @required int initialPage,
  }) {
    assert(initialPage != null);

    pageController = new PageController(
      initialPage: initialPage,
    );
  }

  @protected
  void createNewUniquePageViewKey() {
    pageViewKey = new UniqueKey();
  }

  @protected
  int getCurrentPage() {
    return pageController.page.round();
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      key: pageViewKey,
      controller: pageController,
      itemCount: numberOfPages,
      scrollDirection: widget.scrollDirection,
      pageSnapping: widget.pageSnapping,
      reverse: widget.reverse,
      itemBuilder: null,
    );
  }

  @protected
  Widget itemBuilder(BuildContext context, int page);
}

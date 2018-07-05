import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_pager_controller_communicator.dart';
import 'month_pager_controller.dart';
import 'month_pager_page_builder.dart';

class MonthPager extends StatefulWidget {
  MonthPager._internal({
    @required this.controller,
    @required this.pageBuilder,
    @required this.onPageChanged,
    @required this.scrollDirection,
    @required this.reverse,
    @required this.scrollPhysics,
    @required this.pageSnapping,
  })  : assert(controller != null),
        assert(pageBuilder != null),
        assert(scrollDirection != null),
        assert(reverse != null),
        assert(pageSnapping != null);

  factory MonthPager({
    MonthPagerController controller,
    @required MonthPagerPageBuilder pageBuilder,
    ValueChanged<DateTime> onPageChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics scrollPhysics,
    bool pageSnapping = true,
  }) {
    controller ??= new MonthPagerController();

    return new MonthPager._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onPageChanged: onPageChanged,
      scrollDirection: scrollDirection,
      reverse: reverse,
      scrollPhysics: scrollPhysics,
      pageSnapping: pageSnapping,
    );
  }

  final MonthPagerController controller;

  final MonthPagerPageBuilder pageBuilder;

  final ValueChanged<DateTime> onPageChanged;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollPhysics scrollPhysics;

  final bool pageSnapping;

  @override
  _MonthPagerState createState() => new _MonthPagerState();
}

class _MonthPagerState extends State<MonthPager> {
  PageView _pageView;

  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController(
      initialPage: widget.controller.initialPage,
    );

    _pageView = _createPageView();

    widget.controller.attach(
      _createPagerPosition(),
    );
  }

  @override
  void dispose() {
    widget.controller?.detach();

    super.dispose();
  }

  @override
  void didUpdateWidget(MonthPager oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller ||
        widget.pageBuilder != oldWidget.pageBuilder ||
        widget.onPageChanged != oldWidget.onPageChanged ||
        widget.scrollDirection != oldWidget.scrollDirection ||
        widget.reverse != oldWidget.reverse ||
        widget.scrollPhysics != oldWidget.scrollPhysics ||
        widget.pageSnapping != oldWidget.pageSnapping) {
      DateTime monthOnOldWidget = oldWidget.controller.displayedMonth;
      int initialPageOnNewPageController;

      if (monthOnOldWidget != null) {
        initialPageOnNewPageController = widget.controller.pageOf(
          monthOnOldWidget,
        );
      } else {
        initialPageOnNewPageController = widget.controller.initialPage;
      }

      _pageController = _createPageController(
        initialPage: initialPageOnNewPageController,
      );

      oldWidget.controller.detach();
      widget.controller.attach(
        _createPagerPosition(),
      );

      if (widget.onPageChanged != null) {
        widget.onPageChanged(
          widget.controller.monthOf(initialPageOnNewPageController),
        );
      }

      setState(() {
        _pageView = _createPageView();
      });
    }
  }

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
      itemBuilder: (BuildContext context, int page) {
        DateTime month = widget.controller.monthOf(page);

        return widget.pageBuilder(context, month);
      },
      onPageChanged: _onPageViewPageChanged,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      physics: widget.scrollPhysics,
      pageSnapping: widget.pageSnapping,
      key: new UniqueKey(),
    );
  }

  PagerControllerCommunicator _createPagerPosition() {
    return new PagerControllerCommunicator(
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
      getDisplayedPage: () {
        return _pageController.page.round();
      },
    );
  }

  void _onPageViewPageChanged(int page) {
    if (widget.onPageChanged != null) {
      DateTime monthOfPage = widget.controller.monthOf(page);

      widget.onPageChanged(monthOfPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _pageView;
  }
}

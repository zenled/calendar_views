library week_pager;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;
import 'package:calendar_views/src/internal_date_items/all.dart';

part '_pager_position.dart';

part 'week_pager_controller.dart';

typedef Widget WeekPagerPageBuilder(
  BuildContext context,
  List<DateTime> daysOfWeek,
);

class WeekPager extends StatefulWidget {
  WeekPager({
    @required this.controller,
    @required this.pageBuilder,
    @required this.onPageChanged,
    @required this.scrollDirection,
  })  : assert(controller != null),
        assert(pageBuilder != null),
        assert(scrollDirection != null);

  final WeekPagerController controller;

  final WeekPagerPageBuilder pageBuilder;

  final ValueChanged<List<DateTime>> onPageChanged;

  final Axis scrollDirection;

  @override
  _WeekPagerState createState() => new _WeekPagerState();
}

class _WeekPagerState extends State<WeekPager> {
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
  void didUpdateWidget(WeekPager oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool recreatePageView = false;

    if (widget.controller != oldWidget.controller) {
      List<DateTime> daysOnOldWidget = oldWidget.controller.displayedDays;
      int initialPageOnNewPageController;

      if (daysOnOldWidget != null) {
        initialPageOnNewPageController =
            widget.controller.pageOf(daysOnOldWidget.first);
      } else {
        initialPageOnNewPageController = widget.controller.initialPage;
      }

      _pageController =
          _createPageController(initialPage: initialPageOnNewPageController);

      oldWidget.controller.detach();
      widget.controller.attach(
        _createPagerPosition(),
      );

      widget.onPageChanged(
        widget.controller.daysOf(initialPageOnNewPageController),
      );

      recreatePageView = true;
    }
    if (widget.scrollDirection != oldWidget.scrollDirection) {
      recreatePageView = true;
    }
    if (widget.pageBuilder != oldWidget.pageBuilder) {
      recreatePageView = true;
    }

    if (recreatePageView) {
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
      scrollDirection: widget.scrollDirection,
      itemCount: widget.controller.numberOfPages,
      itemBuilder: (BuildContext context, int page) {
        List<DateTime> daysOfWeek = widget.controller.daysOf(page);

        return widget.pageBuilder(context, daysOfWeek);
      },
      key: new ObjectKey(widget.controller),
    );
  }

  _PagerPosition _createPagerPosition() {
    return new _PagerPosition(
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
      getDisplayedPage: () {
        _pageController.page.round();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          if (widget.onPageChanged != null) {
            int displayedPage = _pageController.page.round();

            List<DateTime> daysOnDisplayedPage =
                widget.controller.daysOf(displayedPage);

            widget.onPageChanged(daysOnDisplayedPage);
          }
        }
      },
      child: _pageView,
    );
  }
}

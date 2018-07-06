library day_pager;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_items/all.dart';

part 'day_pager_controller.dart';

part '_pager_position.dart';

/// Signature for a function that builds a widget for a given [date].
///
/// Values of [date] except for year and month and day are set to their default values.
typedef Widget DayPagerPageBuilder(BuildContext context, DateTime date);

/// Widget similar to [PageView], each page has an assigned date.
class DayPager extends StatefulWidget {
  DayPager._internal({
    @required this.controller,
    @required this.pageBuilder,
    this.onPageChanged,
    @required this.scrollDirection,
  })  : assert(controller != null),
        assert(pageBuilder != null),
        assert(scrollDirection != null);

  /// Creates a scrollable list, that gives each item a date.
  factory DayPager({
    DayPagerController controller,
    @required DayPagerPageBuilder pageBuilder,
    ValueChanged<DateTime> onPageChanged,
    Axis scrollDirection = Axis.horizontal,
  }) {
    controller ??= new DayPagerController();

    return new DayPager._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onPageChanged: onPageChanged,
      scrollDirection: scrollDirection,
    );
  }

  /// Object that is used to control this [DayPager].
  ///
  /// If controller is changed during runtime (eg. new controller with different minimumDate),
  /// all pages will be rebuilt and the widget will try to stay on the same date.
  final DayPagerController controller;

  /// Function that builds the widgets displayed inside this [DayPager].
  final DayPagerPageBuilder pageBuilder;

  /// Called whenever the displayed page changes.
  final ValueChanged<DateTime> onPageChanged;

  /// The axis along which this [DayPager] scrolls.
  final Axis scrollDirection;

  @override
  State createState() => new _DayPagerState();
}

class _DayPagerState extends State<DayPager> {
  /// For displaying the contents for each day.
  PageView _pageView;

  /// Controller for the internal [_pageView].
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController(
      initialPage: widget.controller.initialPage,
    );
    _pageView = _createPageView();

    widget.controller.attach(
      _createDayPagerPosition(),
    );
  }

  @override
  void didUpdateWidget(DayPager oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool recreatePageView = false;

    if (oldWidget.controller != widget.controller) {
      DateTime dateOnOldWidget = oldWidget.controller.displayedDate;
      int initialPageOnNewPageController;

      if (dateOnOldWidget != null) {
        initialPageOnNewPageController =
            widget.controller.pageOf(dateOnOldWidget);
      } else {
        initialPageOnNewPageController = widget.controller.initialPage;
      }

      _pageController = _createPageController(
        initialPage: initialPageOnNewPageController,
      );

      oldWidget.controller.detach();
      widget.controller.attach(
        _createDayPagerPosition(),
      );

      widget.onPageChanged(
        widget.controller.dateOf(initialPageOnNewPageController),
      );

      recreatePageView = true;
    }
    if (oldWidget.scrollDirection != widget.scrollDirection) {
      recreatePageView = true;
    }
    if (oldWidget.pageBuilder != widget.pageBuilder) {
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

  _PagerPosition _createDayPagerPosition() {
    return new _PagerPosition(
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
      getDisplayedPage: () {
        return _pageController.page.round();
      },
    );
  }

  PageView _createPageView() {
    return new PageView.builder(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.controller.numberOfPages,
      itemBuilder: (BuildContext context, int page) {
        DateTime date = widget.controller.dateOf(page);

        return widget.pageBuilder(context, date);
      },
      key: new ObjectKey(widget.controller),
    );
  }

  @override
  void dispose() {
    widget.controller?.detach();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          if (widget.onPageChanged != null) {
            int displayedPage = _pageController.page.round();

            DateTime dateOfDisplayedPage =
                widget.controller.dateOf(displayedPage);

            widget.onPageChanged(dateOfDisplayedPage);
          }
        }
      },
      child: _pageView,
    );
  }
}

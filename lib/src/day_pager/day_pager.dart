import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/internal_date_items/all.dart';

import 'day_pager_controller.dart';
import 'day_pager_position.dart';

/// Signature for a function that builds a widget for a given [date].
///
/// Values of [date] except for year and month and day are set to their default values.
typedef Widget DayPagerPageBuilder(BuildContext context, DateTime date);

class DayPager extends StatefulWidget {
  DayPager._internal({
    @required this.controller,
    @required this.pageBuilder,
    this.onPageChanged,
  })  : assert(controller != null),
        assert(pageBuilder != null);

  factory DayPager({
    DayPagerController controller,
    @required DayPagerPageBuilder pageBuilder,
    ValueChanged<DateTime> onPageChanged,
  }) {
    controller ??= new DayPagerController();

    return new DayPager._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onPageChanged: onPageChanged,
    );
  }

  /// Object that is used to control this DayViewPager.
  final DayPagerController controller;

  /// Function that builds the widgets displayed inside this DayViewPager.
  final DayPagerPageBuilder pageBuilder;

  /// Called whenever the displayed page changes.
  final ValueChanged<DateTime> onPageChanged;

  @override
  State createState() => new _DayPagerState();
}

class _DayPagerState extends State<DayPager> {
  /// Controller for the internal pageView.
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController();
    widget.controller.attach(_createDayPagerPosition());
  }

  @override
  void didUpdateWidget(DayPager oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      _pageController = _createPageController();

      oldWidget.controller.detach();
      widget.controller.attach(_createDayPagerPosition());
    }
  }

  PageController _createPageController() {
    return new PageController(
      initialPage: widget.controller.initialPage,
    );
  }

  DayPagerPosition _createDayPagerPosition() {
    return new DayPagerPosition(
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
      getDisplayedPageCallback: () {
        return _pageController.page.round();
      },
    );
  }

  @override
  void dispose() {
    widget.controller.detach();

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
      child: new PageView.builder(
        controller: _pageController,
        itemCount: widget.controller.numberOfPages,
        itemBuilder: (BuildContext context, int index) {
          DateTime date = widget.controller.dateOf(index);

          return widget.pageBuilder(context, date);
        },
      ),
    );
  }
}

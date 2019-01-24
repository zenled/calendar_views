import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/calendar_page_view/all.dart';

import '_page_days.dart';
import 'days_page_builder.dart';
import 'days_page_controller.dart';
import 'days_page_link.dart';

/// Widget similar to [PageView], but instead of page-number it gives each page a list of days.
///
/// The number of pages that can be displayed is virtually infinite.
class DaysPageView extends CalendarPageView {
  DaysPageView({
    Axis scrollDirection = CalendarPageView.default_scroll_direction,
    bool pageSnapping = CalendarPageView.default_page_snapping,
    bool reverse = CalendarPageView.default_reverse,
    ScrollPhysics physics = CalendarPageView.default_physics,
    DaysPageController controller,
    @required this.pageBuilder,
    this.onDaysChanged,
  })  : this.controller = controller ?? new DaysPageController(),
        assert(controller != null),
        assert(pageBuilder != null),
        super(
          scrollDirection: scrollDirection,
          pageSnapping: pageSnapping,
          reverse: reverse,
          physics: physics,
        );

  /// Object for controlling this widget.
  final DaysPageController controller;

  /// Function that builds a page.
  final DaysPageBuilder pageBuilder;

  /// Called whenever the page and thus displayed days change.
  ///
  /// Properties of days except for year, month and day are set to their default values.
  final ValueChanged<List<DateTime>> onDaysChanged;

  @override
  CalendarPageViewState createState() => new _DaysPageViewState();
}

class _DaysPageViewState extends CalendarPageViewState<DaysPageView> {
  PageDays _pageDays;

  @override
  void initState() {
    super.initState();

    Date firstDayOfInitialPage = new Date.fromDateTime(
      widget.controller.firstDayOfInitialPage,
    );
    _pageDays = new PageDays(
      initialPage: CalendarPageViewState.initial_page,
      firstDayOfInitialPage: firstDayOfInitialPage,
      daysPerPage: widget.controller.daysPerPage,
    );

    _attachToController();
  }

  @override
  void didUpdateWidget(DaysPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.detach();
      _attachToController();
    }
  }

  void _attachToController() {
    widget.controller.attach(
      _createDaysPageLink(),
    );
  }

  DaysPageLink _createDaysPageLink() {
    return new DaysPageLink(
      currentDays: _getCurrentDays,
      jumpToDay: _jumpToDay,
      animateToDay: _animateToDay,
      currentPage: getCurrentPage,
      jumpToPage: jumpToPage,
      animateToPage: animateToPage,
    );
  }

  List<DateTime> _getCurrentDays() {
    int currentPage = getCurrentPage();
    List<Date> currentDates = _pageDays.daysOfPage(currentPage);

    return _datesToDateTime(currentDates);
  }

  void _jumpToDay(DateTime day) {
    Date d = new Date.fromDateTime(day);
    int page = _pageDays.pageOfDay(d);

    jumpToPage(page);
  }

  Future<void> _animateToDay(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    Date d = new Date.fromDateTime(day);
    int page = _pageDays.pageOfDay(d);

    return animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  @override
  void onPageChanged(int page) {
    if (widget.onDaysChanged != null) {
      List<Date> dates = _pageDays.daysOfPage(page);
      List<DateTime> days = _datesToDateTime(dates);

      widget.onDaysChanged(days);
    }
  }

  @override
  Widget itemBuilder(BuildContext context, int page) {
    List<Date> dates = _pageDays.daysOfPage(page);
    List<DateTime> days = _datesToDateTime(dates);

    return widget.pageBuilder(context, days);
  }

  List<DateTime> _datesToDateTime(List<Date> dates) {
    return dates.map((date) => date.toDateTime()).toList();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/_utils/all.dart';
import 'package:calendar_views/month_page_view.dart';

import '_month_constraints_validator.dart';
import '_page_month.dart';

class MonthPageView extends StatefulWidget {
  MonthPageView({
    @required this.minimumMonth,
    this.maximumMonth,
    @required this.controller,
    @required this.pageBuilder,
    this.scrollDirection = Axis.horizontal,
    this.pageSnapping = true,
    this.reverse = false,
    this.onMonthChanged,
  })  : assert(minimumMonth != null),
        assert(controller != null),
        assert(pageBuilder != null),
        assert(scrollDirection != null),
        assert(pageSnapping != null),
        assert(reverse != null) {
    MonthConstraintsValidator validator = new MonthConstraintsValidator(
      minimumMonth: new Month.fromDateTime(minimumMonth),
      maximumMonth:
          maximumMonth != null ? new Month.fromDateTime(maximumMonth) : null,
    );
    validator.validateMinimumMonth();
    validator.validateMaximumMonth();
  }

  final DateTime minimumMonth;
  final DateTime maximumMonth;

  final MonthPageController controller;
  final MonthPageBuilder pageBuilder;

  final Axis scrollDirection;
  final bool pageSnapping;
  final bool reverse;

  final ValueChanged<DateTime> onMonthChanged;

  @override
  State createState() => new _MonthPageViewState();
}

class _MonthPageViewState extends State<MonthPageView> {
  PageController _pageController;
  Key _pageViewKey;

  PageMonth _pageMonth;

  @override
  void initState() {
    super.initState();

    _createPageMonth();
    _initPageController();
    _createNewUniquePageViewKey();
    _attachToController();
  }

  void _initPageController() {
    DateTime initialMonth = widget.controller.initialMonth;

    int initialPage =
        _pageMonth.pageOfMonth(new Month.fromDateTime(initialMonth));

    _createPageController(
      initialPage: initialPage,
    );
  }

  @override
  void didUpdateWidget(MonthPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.detach();
      _attachToController();
    }

    if (!isSameYearAndMonth(widget.minimumMonth, oldWidget.minimumMonth) ||
        _areMaximumMonthsDifferent(
            widget.maximumMonth, oldWidget.maximumMonth) ||
        widget.scrollDirection != oldWidget.scrollDirection) {
      DateTime currentMonth = _getCurrentMonth();

      _createPageMonth();

      int initialPage =
          _pageMonth.pageOfMonth(new Month.fromDateTime(currentMonth));
      _createPageController(initialPage: initialPage);
      _createNewUniquePageViewKey();
    }
  }

  bool _areMaximumMonthsDifferent(DateTime month1, DateTime month2) {
    if (month1 == null && month2 == null) {
      return false;
    }
    if (month1 == null || month2 == null) {
      return true;
    }
    return isSameYearAndMonth(month1, month2);
  }

  void _createPageMonth() {
    _pageMonth = new PageMonth(
      minimumMonth: new Month.fromDateTime(widget.minimumMonth),
      maximumMonth: widget.maximumMonth != null
          ? new Month.fromDateTime(widget.maximumMonth)
          : null,
    );
  }

  void _createNewUniquePageViewKey() {
    _pageViewKey = new UniqueKey();
  }

  void _createPageController({
    @required int initialPage,
  }) {
    assert(initialPage != null);

    _pageController = new PageController(
      initialPage: initialPage,
    );
  }

  void _attachToController() {
    widget.controller.attach(
      _createCommunicator(),
    );
  }

  MonthPageCommunicator _createCommunicator() {
    return new MonthPageCommunicator(
      currentMonth: _getCurrentMonth,
      jumpToMonth: _jumpToMonth,
      animateToMonth: _animateToMonth,
      currentPage: _getCurrentPage,
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
    );
  }

  DateTime _getCurrentMonth() {
    int page = _getCurrentPage();
    return _pageMonth.monthOfPage(page).toDateTime();
  }

  void _jumpToMonth(DateTime month) {
    int page = _pageMonth.pageOfMonth(new Month.fromDateTime(month));

    _pageController.jumpToPage(page);
  }

  Future<Null> _animateToMonth(
    DateTime month, {
    @required Duration duration,
    @required Curve curve,
  }) {
    int page = _pageMonth.pageOfMonth(new Month.fromDateTime(month));

    return _pageController.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  int _getCurrentPage() {
    return _pageController.page.round();
  }

  void _onPageChanged(int page) {
    if (widget.onMonthChanged != null) {
      Month month = _pageMonth.monthOfPage(page);

      widget.onMonthChanged(month.toDateTime());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      key: _pageViewKey,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: _pageBuilder,
      itemCount: _pageMonth.numberOfPages,
      scrollDirection: widget.scrollDirection,
      pageSnapping: widget.pageSnapping,
      reverse: widget.reverse,
    );
  }

  Widget _pageBuilder(BuildContext context, int page) {
    Month month = _pageMonth.monthOfPage(page);

    return widget.pageBuilder(context, month.toDateTime());
  }
}

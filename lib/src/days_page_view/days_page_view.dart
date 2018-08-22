import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import '_helpers/all.dart';
import 'days_constraints.dart';
import 'days_page_builder.dart';
import 'days_page_communicator.dart';
import 'days_page_controller.dart';

class DaysPageView extends StatefulWidget {
  DaysPageView({
    @required this.constraints,
    @required this.controller,
    @required this.pageBuilder,
    this.onDaysChanged,
    this.scrollDirection = Axis.horizontal,
    this.pageSnapping = true,
    this.reverse = false,
  })  : assert(constraints != null),
        assert(controller != null),
        assert(pageBuilder != null),
        assert(scrollDirection != null),
        assert(pageSnapping != null),
        assert(reverse != null);

  final DaysConstraints constraints;
  final DaysPageController controller;
  final DaysPageBuilder pageBuilder;

  final Axis scrollDirection;
  final bool pageSnapping;
  final bool reverse;

  final ValueChanged<List<DateTime>> onDaysChanged;

  @override
  State createState() => new _DaysPageViewState();
}

class _DaysPageViewState extends State<DaysPageView> {
  PageController _pageController;
  Key _pageViewKey;

  PageDays _pageDays;

  @override
  void initState() {
    super.initState();

    _createPageDays();
    _initPageController();
    _createNewUniquePageViewKey();
    _attachToController();
  }

  void _initPageController() {
    DateTime initialDay = widget.controller.initialDay;
    Date initialDate = new Date.fromDateTime(initialDay);

    int initialPage = _pageDays.pageOfDate(initialDate);

    _createPageController(initialPage: initialPage);
  }

  @override
  void didUpdateWidget(DaysPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    Date representationOfCurrentPage = getRepresentationOfCurrentPage();

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.detach();
      _attachToController();
    }

    if (widget.constraints != oldWidget.constraints ||
        widget.scrollDirection != oldWidget.scrollDirection) {
      _createPageDays();

      int initialPage = _pageDays.pageOfDate(representationOfCurrentPage);
      _createPageController(initialPage: initialPage);
      _createNewUniquePageViewKey();
    }
  }

  Date getRepresentationOfCurrentPage() {
    int currentPage = _pageController.page.round();
    return _pageDays.getFirstDateOfPage(currentPage);
  }

  void _createNewUniquePageViewKey() {
    _pageViewKey = new UniqueKey();
  }

  void _createPageDays() {
    _pageDays = new PageDays(
      daysPerPage: widget.constraints.daysPerPage,
      minimumDate: new Date.fromDateTime(widget.constraints.minimumDay),
      maximumDate: new Date.fromDateTime(widget.constraints.maximumDay),
    );
  }

  void _createPageController({
    @required int initialPage,
  }) {
    assert(initialPage != null);

    _pageController = new PageController(
      initialPage: initialPage,
    );
  }

  void _onPageChanged(int page) {
    if (widget.onDaysChanged == null) return;

    List<DateTime> daysOfPage = _daysOfPage(page);
    widget.onDaysChanged(daysOfPage);
  }

  void _attachToController() {
    widget.controller.attach(_createCommunicator());
  }

  DaysPageCommunicator _createCommunicator() {
    return new DaysPageCommunicator(
      displayedDays: () {
        int displayedPage = _pageController.page.round();
        return _daysOfPage(displayedPage);
      },
      jumpToDay: (DateTime day) {
        Date date = new Date.fromDateTime(day);
        int page = _pageDays.pageOfDate(date);
        _pageController.jumpToPage(page);
      },
      animateToDay: (
        DateTime day, {
        @required Duration duration,
        @required Curve curve,
      }) {
        Date date = new Date.fromDateTime(day);
        int page = _pageDays.pageOfDate(date);
        _pageController.animateToPage(
          page,
          duration: duration,
          curve: curve,
        );
      },
      jumpToPage: _pageController.jumpToPage,
      animateToPage: _pageController.animateToPage,
    );
  }

  List<DateTime> _daysOfPage(int page) {
    List<Date> datesOfPage = _pageDays.datesOfPage(page);

    return datesOfPage
        .map(
          (date) => date.toDateTime(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      key: _pageViewKey,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: _pageBuilder,
      itemCount: _pageDays.numberOfPages,
      scrollDirection: widget.scrollDirection,
      pageSnapping: widget.pageSnapping,
      reverse: widget.reverse,
    );
  }

  Widget _pageBuilder(BuildContext context, int page) {
    List<DateTime> daysOfPage = _daysOfPage(page);

    return widget.pageBuilder(context, daysOfPage);
  }
}

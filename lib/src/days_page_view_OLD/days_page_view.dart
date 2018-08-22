import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import 'controller/_page_days.dart';
import 'controller/days_page_controller.dart';
import 'days_page_builder.dart';
import 'communicator.dart';

class DaysPageView extends StatefulWidget {
  DaysPageView({
    equired this.daysPerPage,
    @required this.minimumDay,
    @required this.maximumDay,
    @required this.controller,
  });

  final int daysPerPage;
  final DateTime minimumDay;
  final DateTime maximumDay;

  final DaysPageController controller;

  @override
  State createState() => new _DaysPageViewState();
}

class _DaysPageViewState extends State<DaysPageView> {
  PageView _pageView;
  PageController _pageController;
  Key _keyOfPageView;

  PageDays _pageDays;

  Date get minimumDay => new Date.fromDateTime(widget.minimumDay);

  Date get maximumDay => widget.maximumDay != null
      ? new Date.fromDateTime(widget.maximumDay)
      : null;

  @override
  void initState() {
    super.initState();

    _pageDays = new PageDays(
      daysPerPage: widget.daysPerPage,
      minimumDay: minimumDay,
      maximumDayCandidate: maximumDay,
    );
  }

  Communicator createCommunicator() {
    return new Communicator(
      jumpToDay: (DateTime day) {
        int page = _pageDays.pageOfDay(new Date.fromDateTime(day));
        _pageController.jumpToPage(page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {}
}@r

/// Custom pageView in which each page represents one or more consecutive days.
class DaysPageViewOLD extends CalendarPageView {
  /// Creates pageView with each page representing one or more consecutive days.
  DaysPageViewOLD({
    @required this.minimumDay,
    this.maximumDay,
    @required this.controller,
    @required this.pageBuilder,
    this.onDaysChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics physics,
    bool pageSnapping = true,
  })  : assert(minimumDay != null),
        assert(controller != null),
        assert(pageBuilder != null),
        super(
          scrollDirection: scrollDirection,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
        );

  final DateTime minimumDay;

  final DateTime maximumDay;

  /// Object in charge of controlling this [DaysPageViewOLD].
  final DaysPageControllerOLD controller;

  /// Function that builds a page.
  final DaysPageBuilder pageBuilder;

  /// Called whenever displayed days in this [DaysPageViewOLD] changes.
  final ValueChanged<List<DateTime>> onDaysChanged;

  @override
  _DaysPageViewStateOLD createState() => new _DaysPageViewStateOLD();
}

class _DaysPageViewStateOLD extends CalendarPageViewState<DaysPageViewOLD> {
  Date get minimumDay => new Date.fromDateTime(widget.minimumDay);

  Date get maximumDay => widget.maximumDay != null
      ? new Date.fromDateTime(widget.maximumDay)
      : null;

  @override
  bool hasAnythingChanged(DaysPageViewOLD oldWidget) {
    return widget.controller != oldWidget.controller ||
        !identical(widget.pageBuilder, oldWidget.pageBuilder) ||
        !identical(widget.onDaysChanged, oldWidget.onDaysChanged);
  }

  @override
  void onPageChanged(int page) {
    if (widget.onDaysChanged != null) {
      List<DateTime> days = widget.controller.daysOfPage(page);

      widget.onDaysChanged(days);
    }
  }

  @override
  Widget pageBuilder(BuildContext context, int page) {
    List<DateTime> daysOfPage = widget.controller.daysOfPage(page);

    return widget.pageBuilder(context, daysOfPage);
  }
}

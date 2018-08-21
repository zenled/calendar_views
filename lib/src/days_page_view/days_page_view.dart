import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'controller/days_page_controller.dart';
import 'days_page_builder.dart';

/// Custom pageView in which each page represents one or more consecutive days.
class DaysPageView extends CalendarPageView {
  /// Creates pageView with each page representing one or more consecutive days.
  DaysPageView({
    @required this.controller,
    @required this.pageBuilder,
    this.onDaysChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics physics,
    bool pageSnapping = true,
  })  : assert(controller != null),
        assert(pageBuilder != null),
        super(
          scrollDirection: scrollDirection,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
        );

  /// Object in charge of controlling this [DaysPageView].
  final DaysPageController controller;

  /// Function that builds a page.
  final DaysPageBuilder pageBuilder;

  /// Called whenever displayed days in this [DaysPageView] changes.
  final ValueChanged<List<DateTime>> onDaysChanged;

  @override
  _DaysPageViewState createState() => new _DaysPageViewState();
}

class _DaysPageViewState extends CalendarPageViewState<DaysPageView> {
  @override
  bool hasAnythingChanged(DaysPageView oldWidget) {
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

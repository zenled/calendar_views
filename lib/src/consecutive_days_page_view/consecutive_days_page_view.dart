import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_calendar_page_view/all.dart';

import 'week_page_builder.dart';
import 'week_page_controller.dart';

class WeekPageView extends CalendarPageView {
  WeekPageView._internal({
    @required this.controller,
    @required this.pageBuilder,
    @required this.onWeekChanged,
    @required Axis scrollDirection,
    @required bool reverse,
    @required ScrollPhysics physics,
    @required bool pageSnapping,
  })  : assert(controller != null),
        assert(pageBuilder != null),
        super(
          scrollDirection: scrollDirection,
          reverse: reverse,
          physics: physics,
          pageSnapping: pageSnapping,
        );

  /// Creates pageView with each page representing a week.
  factory WeekPageView({
    WeekPageController controller,
    @required WeekPageBuilder pageBuilder,
    ValueChanged<DateTime> onWeekChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics scrollPhysics,
    bool pageSnapping = true,
  }) {
    controller ??= new WeekPageController();

    return new WeekPageView._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onWeekChanged: onWeekChanged,
      scrollDirection: scrollDirection,
      reverse: reverse,
      physics: scrollPhysics,
      pageSnapping: pageSnapping,
    );
  }

  /// Object in charge of controlling this [WeekPageView].
  final WeekPageController controller;

  /// Function that builds a page.
  final WeekPageBuilder pageBuilder;

  /// Called whenever displayed week in this [WeekPageView] changes.
  final ValueChanged<DateTime> onWeekChanged;

  @override
  _WeekPageViewState createState() => new _WeekPageViewState();
}

class _WeekPageViewState extends CalendarPageViewState<WeekPageView> {
  @override
  bool hasAnythingChanged(WeekPageView oldWidget) {
    return widget.controller != oldWidget.controller ||
        !identical(widget.pageBuilder, oldWidget.pageBuilder) ||
        !identical(widget.onWeekChanged, oldWidget.onWeekChanged);
  }

  @override
  void onPageChanged(int page) {
    if (widget.onWeekChanged != null) {
      DateTime week = widget.controller.weekOfPage(page);

      widget.onWeekChanged(week);
    }
  }

  @override
  Widget pageBuilder(BuildContext context, int page) {
    List<DateTime> daysOfPage = widget.controller.daysOfPage(page);

    return widget.pageBuilder(context, daysOfPage);
  }
}

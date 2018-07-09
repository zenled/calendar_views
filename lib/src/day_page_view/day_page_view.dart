import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'day_page_builder.dart';
import 'day_page_controller.dart';

/// Custom pageView in which each page represents a day.
class DayPageView extends CalendarPageView {
  DayPageView._internal({
    @required this.controller,
    @required this.pageBuilder,
    @required this.onDayChanged,
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

  /// Creates pageView with each page representing a day.
  factory DayPageView({
    DayPageController controller,
    @required DayPageBuilder pageBuilder,
    ValueChanged<DateTime> onDayChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics scrollPhysics,
    bool pageSnapping = true,
  }) {
    controller ??= new DayPageController();

    return new DayPageView._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onDayChanged: onDayChanged,
      scrollDirection: scrollDirection,
      reverse: reverse,
      physics: scrollPhysics,
      pageSnapping: pageSnapping,
    );
  }

  /// Object in charge of controlling this [DayPageView].
  final DayPageController controller;

  /// Function that builds a page.
  final DayPageBuilder pageBuilder;

  /// Called whenever displayed day in this [DayPageView] changes.
  final ValueChanged<DateTime> onDayChanged;

  @override
  _DayPageViewState createState() => new _DayPageViewState();
}

class _DayPageViewState extends CalendarPageViewState<DayPageView> {
  @override
  bool hasAnythingChanged(DayPageView oldWidget) {
    return widget.controller != oldWidget.controller ||
        !identical(widget.pageBuilder, oldWidget.pageBuilder) ||
        !identical(widget.onDayChanged, oldWidget.onDayChanged);
  }

  @override
  void onPageChanged(int page) {
    if (widget.onDayChanged != null) {
      DateTime day = widget.controller.dayOfPage(page);

      widget.onDayChanged(day);
    }
  }

  @override
  Widget pageBuilder(BuildContext context, int page) {
    DateTime day = widget.controller.dayOfPage(page);

    return widget.pageBuilder(context, day);
  }
}

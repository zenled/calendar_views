import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_page_view/all.dart';

import 'consecutive_days_page_builder.dart';
import 'consecutive_days_page_controller.dart';

/// Custom pageView in which each page represents some consecutive days.
class ConsecutiveDaysPageView extends CalendarPageView {
  ConsecutiveDaysPageView._internal({
    @required this.controller,
    @required this.pageBuilder,
    @required this.onDaysChanged,
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
  factory ConsecutiveDaysPageView({
    ConsecutiveDaysPageController controller,
    @required ConsecutiveDaysPageBuilder pageBuilder,
    ValueChanged<List<DateTime>> onDaysChanged,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    ScrollPhysics scrollPhysics,
    bool pageSnapping = true,
  }) {
    controller ??= new ConsecutiveDaysPageController();

    return new ConsecutiveDaysPageView._internal(
      controller: controller,
      pageBuilder: pageBuilder,
      onDaysChanged: onDaysChanged,
      scrollDirection: scrollDirection,
      reverse: reverse,
      physics: scrollPhysics,
      pageSnapping: pageSnapping,
    );
  }

  /// Object in charge of controlling this [ConsecutiveDaysPageView].
  final ConsecutiveDaysPageController controller;

  /// Function that builds a page.
  final ConsecutiveDaysPageBuilder pageBuilder;

  /// Called whenever displayed days in this [ConsecutiveDaysPageView] changes.
  final ValueChanged<List<DateTime>> onDaysChanged;

  @override
  _ConsecutiveDaysPageView createState() => new _ConsecutiveDaysPageView();
}

class _ConsecutiveDaysPageView
    extends CalendarPageViewState<ConsecutiveDaysPageView> {
  @override
  bool hasAnythingChanged(ConsecutiveDaysPageView oldWidget) {
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

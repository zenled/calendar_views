import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import '_month_view_days_generator.dart';
import 'day_of_month.dart';
import 'day_of_month_builder.dart';
import 'month_view_header_item_builder.dart';

/// Widget for displaying a grid of days of some [month] and optionally a header.
class MonthView extends StatefulWidget {
  MonthView({
    @required this.month,
    this.firstWeekday = DateTime.monday,
    @required this.dayOfMonthBuilder,
    this.headerItemBuilder,
    this.showExtendedDaysBefore = true,
    this.showExtendedDaysAfter = true,
  })  : assert(month != null),
        assert(firstWeekday != null && isWeekdayValid(firstWeekday)),
        assert(dayOfMonthBuilder != null),
        assert(showExtendedDaysBefore != null),
        assert(showExtendedDaysAfter != null);

  /// Month of which days to display.
  final DateTime month;

  /// First day of week.
  final int firstWeekday;

  /// Function that builds a day of month.
  final DayOfMonthBuilder dayOfMonthBuilder;

  /// Function that builds a header item.
  ///
  /// If null, a header won't be displayed.
  final MonthViewHeaderItemBuilder headerItemBuilder;

  /// If true extended days before [month] will be shown.
  ///
  /// Extended days are days that are not part of [month] but can still be visible in a month view.
  final bool showExtendedDaysBefore;

  /// If true extended days after [month] will be shown.
  ///
  /// Extended days are days that are not part of [month] but can still be visible in a month view.
  final bool showExtendedDaysAfter;

  @override
  _MonthViewState createState() => new _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  List<int> _weekdays;
  List<DayOfMonth> _days;

  bool get _shouldBuildHeader => widget.headerItemBuilder != null;

  @override
  void initState() {
    super.initState();

    _weekdays = _generateWeekdays();
    _days = _generateDays();
  }

  @override
  void didUpdateWidget(MonthView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!isSameYearAndMonth(widget.month, oldWidget.month) ||
        widget.firstWeekday != oldWidget.firstWeekday) {
      _weekdays = _generateWeekdays();
      _days = _generateDays();
    }
  }

  List<int> _generateWeekdays() {
    List<int> weekdays = <int>[];

    int firstWeekdayBase0 = widget.firstWeekday - 1;
    for (int i = 0; i < DateTime.daysPerWeek; i++) {
      int weekdayBase0 = (firstWeekdayBase0 + i) % DateTime.daysPerWeek;
      int weekday = weekdayBase0 + 1;

      weekdays.add(weekday);
    }

    return weekdays;
  }

  List<DayOfMonth> _generateDays() {
    MonthViewDaysGenerator generator = new MonthViewDaysGenerator(
      month: new Month.fromDateTime(widget.month),
      firstWeekday: widget.firstWeekday,
    );

    return generator.generate();
  }

  List<List<DayOfMonth>> _makeWeeks() {
    List<List<DayOfMonth>> weeks = new List();

    for (int i = 0; i < _days.length; i += DateTime.daysPerWeek) {
      weeks.add(
        _days.getRange(i, i + DateTime.daysPerWeek).toList(),
      );
    }

    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnItems = <Widget>[];

    if (_shouldBuildHeader) {
      columnItems.add(
        _buildHeader(),
      );
    }

    columnItems.addAll(
      _buildWeeks(),
    );

    return new Column(
      children: columnItems,
    );
  }

  Widget _buildHeader() {
    return new IntrinsicHeight(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _weekdays
            .map(
              (weekday) => new Expanded(
                    child: widget.headerItemBuilder(context, weekday),
                  ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = <Widget>[];

    for (List<DayOfMonth> week in _makeWeeks()) {
      weeks.add(
        _buildWeek(week),
      );
    }

    return weeks;
  }

  Widget _buildWeek(List<DayOfMonth> week) {
    List<Widget> daysOfWeek = week
        .map(
          (day) => _buildDay(day),
        )
        .toList();

    return new Expanded(
      child: new Row(
        children: daysOfWeek,
      ),
    );
  }

  Widget _buildDay(DayOfMonth day) {
    Widget dayWidget;

    if (_shouldDayBeShown(day)) {
      dayWidget = _buildVisibleDay(day);
    } else {
      dayWidget = _buildInvisibleDay();
    }

    return new Expanded(
      child: dayWidget,
    );
  }

  bool _shouldDayBeShown(DayOfMonth day) {
    if (!day.isExtended) {
      return true;
    } else if (day.isExtendedBefore && widget.showExtendedDaysBefore) {
      return true;
    } else if (day.isExtendedAfter && widget.showExtendedDaysAfter) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildVisibleDay(DayOfMonth day) {
    return widget.dayOfMonthBuilder(context, day);
  }

  Widget _buildInvisibleDay() {
    return new Container(
      constraints: new BoxConstraints.expand(),
    );
  }
}

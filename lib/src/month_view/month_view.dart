import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_extended_days_of_month_generator.dart';
import '_month_view_day.dart';
import 'day_of_month_properties.dart';
import 'day_of_month_builder.dart';

import 'package:calendar_views/src/utils/all.dart' as utils;

class MonthView extends StatefulWidget {
  MonthView({
    @required this.month,
    this.firstWeekday = DateTime.monday,
    @required this.dayOfMonthBuilder,
    this.rebuildDayWhenEventsChange = false,
    this.showExtendedDaysBefore = true,
    this.showExtendedDaysAfter = true,
    Key key,
  })  : assert(month != null),
        assert(firstWeekday != null && utils.isValidWeekday(firstWeekday)),
        assert(dayOfMonthBuilder != null),
        assert(rebuildDayWhenEventsChange != null),
        assert(showExtendedDaysBefore != null),
        assert(showExtendedDaysAfter != null),
        super(key: key);

  final DateTime month;

  final int firstWeekday;

  final DayOfMonthBuilder dayOfMonthBuilder;

  final bool rebuildDayWhenEventsChange;

  final bool showExtendedDaysBefore;

  final bool showExtendedDaysAfter;

  @override
  _MonthViewState createState() => new _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  List<DayOfMonthProperties> _days;

  @override
  void initState() {
    super.initState();

    _days = _generateExtendedDays();
  }

  @override
  void didUpdateWidget(MonthView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!utils.isSameYearAndMonth(widget.month, oldWidget.month) ||
        widget.firstWeekday != oldWidget.firstWeekday) {
      List<DayOfMonthProperties> newDays = _generateExtendedDays();

      setState(() {
        _days = newDays;
      });
    }
  }

  List<DayOfMonthProperties> _generateExtendedDays() {
    ExtendedDaysOfMonthGenerator daysGenerator =
        new ExtendedDaysOfMonthGenerator(
      month: widget.month,
      firstWeekday: widget.firstWeekday,
    );

    return daysGenerator.generate();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      children: _buildWeeks(),
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = <Widget>[];

    for (int i = 0; i < _days.length; i += 7) {
      List<DayOfMonthProperties> daysOfWeek = _days.getRange(i, i + 7).toList();

      weeks.add(
        _buildWeek(daysOfWeek),
      );
    }

    return weeks;
  }

  Widget _buildWeek(List<DayOfMonthProperties> daysOfWeek) {
    return new Expanded(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: daysOfWeek
            .map(
              (dayOfWeek) => _buildDay(dayOfWeek),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDay(DayOfMonthProperties day) {
    return new Expanded(
      child: _buildDayContents(day),
    );
  }

  Widget _buildDayContents(DayOfMonthProperties day) {
    if (_shouldDayBeShown(day)) {
      return _buildVisibleDay(day);
    } else {
      return _buildInvisibleDay();
    }
  }

  Widget _buildVisibleDay(DayOfMonthProperties day) {
    return new MonthViewDay(
      properties: day,
      rebuildWhenEventsChange: widget.rebuildDayWhenEventsChange,
      builder: widget.dayOfMonthBuilder,
      key: new ObjectKey(day),
    );
  }

  Widget _buildInvisibleDay() {
    return new Container(
      constraints: new BoxConstraints.expand(),
    );
  }

  bool _shouldDayBeShown(DayOfMonthProperties day) {
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
}

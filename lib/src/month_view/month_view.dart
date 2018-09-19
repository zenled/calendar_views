import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

import '_extended_days_of_month_generator.dart';
import '_month_view_day.dart';
import 'day_of_month_properties.dart';
import 'day_of_month_builder.dart';

/// Widget for displaying a grid of consecutive days all belonging or extended from [month].
class MonthView extends StatefulWidget {
  MonthView({
    @required this.month,
    this.firstWeekday = DateTime.monday,
    @required this.dayOfMonthBuilder,
    this.showExtendedDaysBefore = true,
    this.showExtendedDaysAfter = true,
    Key key,
  })  : assert(month != null),
        assert(firstWeekday != null && isWeekdayValid(firstWeekday)),
        assert(dayOfMonthBuilder != null),
        assert(showExtendedDaysBefore != null),
        assert(showExtendedDaysAfter != null),
        super(key: key);

  /// Month days or extended days of which this widget is displaying.
  final DateTime month;

  /// Day of week on which the week start.
  final int firstWeekday;

  /// Function that builds a day of month.
  final DayOfMonthBuilder dayOfMonthBuilder;

  /// If true days that don't belong to [month] but do belong to week that is before and on [month] will be shown.
  final bool showExtendedDaysBefore;

  /// If true days that don't belong to [month] but do belong to week that is after and on [month] will be shown.
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

    if (!isSameYearAndMonth(widget.month, oldWidget.month) ||
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

  List<List<DayOfMonthProperties>> _makeWeeksFrom(
    List<DayOfMonthProperties> days,
  ) {
    assert(days.length % 7 == 0);

    List<List<DayOfMonthProperties>> weeks = new List();

    for (int i = 0; i < days.length; i += DateTime.daysPerWeek) {
      weeks.add(
        days.getRange(i, i + DateTime.daysPerWeek).toList(),
      );
    }

    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: _buildWeeks(),
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = <Widget>[];

    for (List<DayOfMonthProperties> daysOfWeek in _makeWeeksFrom(_days)) {
      weeks.add(
        _buildWeek(daysOfWeek),
      );
    }

    return weeks;
  }

  Widget _buildWeek(List<DayOfMonthProperties> daysOfWeek) {
    return new Expanded(
      child: new Row(
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

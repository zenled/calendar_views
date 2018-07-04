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
    this.automaticallyRefresh = true,
    this.showBeforeExtendedDays = true,
    this.showAfterExtendedDays = true,
  })  : assert(month != null),
        assert(firstWeekday != null && utils.isValidWeekday(firstWeekday)),
        assert(dayOfMonthBuilder != null),
        assert(automaticallyRefresh != null),
        assert(showBeforeExtendedDays != null),
        assert(showAfterExtendedDays != null);

  final DateTime month;

  final int firstWeekday;

  final DayOfMonthBuilder dayOfMonthBuilder;

  final bool automaticallyRefresh;

  final bool showBeforeExtendedDays;

  final bool showAfterExtendedDays;

  @override
  _MonthViewState createState() => new _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
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

    List<DayOfMonthProperties> allDays = _generateExtendedDays();
    for (int i = 0; i < allDays.length; i += 7) {
      List<DayOfMonthProperties> daysOfWeek =
          allDays.getRange(i, i + 7).toList();

      weeks.add(
        new Expanded(
          child: _buildWeek(daysOfWeek),
        ),
      );
    }

    return weeks;
  }

  Widget _buildWeek(List<DayOfMonthProperties> daysOfWeek) {
    return new Row(
      children: daysOfWeek
          .map(
            (dayOfWeek) => new Row(
                  children: daysOfWeek
                      .map(
                        (dayOfWeek) => new Expanded(
                              child: _buildDay(dayOfWeek),
                            ),
                      )
                      .toList(),
                ),
          )
          .toList(),
    );
  }

  Widget _buildDay(DayOfMonthProperties day) {
    if (_shouldDayBeShown(day)) {
      return new MonthViewDay(
        automaticallyRefresh: widget.automaticallyRefresh,
        builder: widget.dayOfMonthBuilder,
        properties: day,
      );
    } else {
      return new Container(
        constraints: new BoxConstraints.expand(),
      );
    }
  }

  bool _shouldDayBeShown(DayOfMonthProperties day) {
    if (!day.isExtended) {
      return true;
    } else if (day.isExtendedBefore && widget.showBeforeExtendedDays) {
      return true;
    } else if (day.isExtendedAfter && widget.showAfterExtendedDays) {
      return true;
    } else {
      return false;
    }
  }
}

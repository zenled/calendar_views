import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Widget that can display a widget in each [DayViewArea].
class DayViewDaysHeader extends StatefulWidget {
  DayViewDaysHeader({
    @required this.headerItemBuilder,
  }) : assert(headerItemBuilder != null);

  final DayViewDaysHeaderItemBuilder headerItemBuilder;

  @override
  State createState() => new _DayViewDaysHeaderState();
}

class _DayViewDaysHeaderState extends State<DayViewDaysHeader> {
  DayViewEssentialsState _dayViewEssentials;

  HorizontalPositioner get _horizontalPositioner =>
      _dayViewEssentials.horizontalPositioner;

  DayViewProperties get _dayViewProperties => _horizontalPositioner.properties;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dayViewEssentials = DayViewEssentials.of(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = <Widget>[];

    rowChildren.add(
      _buildStartingOffset(),
    );

    rowChildren.addAll(
      _buildDaysAndSeparations(),
    );

    rowChildren.add(
      _buildEndingOffset(),
    );

    return new Container(
      width: _horizontalPositioner.totalWidth,
      child: new IntrinsicHeight(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rowChildren,
        ),
      ),
    );
  }

  Widget _buildStartingOffset() {
    double width = _horizontalPositioner.eventAreaLeft;

    return new Container(
      width: width,
    );
  }

  List<Widget> _buildDaysAndSeparations() {
    List<Widget> daysAndSeparations = <Widget>[];

    List<DateTime> days = _dayViewProperties.days;
    for (int dayNumber = 0; dayNumber < days.length; dayNumber++) {
      DateTime day = days[dayNumber];

      daysAndSeparations.add(
        _buildDay(
          context: context,
          dayNumber: dayNumber,
          day: day,
        ),
      );

      if (_isDaySeparationAfterDay(dayNumber)) {
        int daySeparationNumber = _daySeparationNumberOfDayNumber(dayNumber);
        daysAndSeparations.add(
          _buildDaySeparation(
            context: context,
            daySeparationNumber: daySeparationNumber,
          ),
        );
      }
    }

    return daysAndSeparations;
  }

  Widget _buildDay({
    @required BuildContext context,
    @required int dayNumber,
    @required DateTime day,
  }) {
    return new Container(
      width: _horizontalPositioner.dayAreaWidth(dayNumber),
      child: widget.headerItemBuilder(context, day),
    );
  }

  bool _isDaySeparationAfterDay(int dayNumber) {
    if (!_isLastDay(dayNumber)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLastDay(int dayNumber) {
    return dayNumber == (_dayViewProperties.numberOfDays - 1);
  }

  int _daySeparationNumberOfDayNumber(int dayNumber) {
    return dayNumber;
  }

  Widget _buildDaySeparation({
    @required BuildContext context,
    @required int daySeparationNumber,
  }) {
    return new Container(
      width: _horizontalPositioner.daySeparationAreaWidth(daySeparationNumber),
    );
  }

  Widget _buildEndingOffset() {
    return new Container(
      width: _endingOffsetWidth,
    );
  }

  double get _endingOffsetWidth =>
      _horizontalPositioner.endMainAreaWidth +
      _horizontalPositioner.endTotalAreaWidth;
}

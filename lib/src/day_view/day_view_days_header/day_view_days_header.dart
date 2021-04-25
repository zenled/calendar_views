import 'package:calendar_views/day_view.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget that builds a child in place of each day in a day view.
class DayViewDaysHeader extends StatefulWidget {
  DayViewDaysHeader({
    @required this.headerItemBuilder,
  }) : assert(headerItemBuilder != null);

  /// Function that builds a header item.
  final DayViewDaysHeaderItemBuilder headerItemBuilder;

  @override
  State createState() => _DayViewDaysHeaderState();
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
    if (_dayViewEssentials == null) {
      _throwNoDayViewEssentialsError();
    }
  }

  void _throwNoDayViewEssentialsError() {
    throw FlutterError("""
Could not inherit DayViewEssentials.

This widget must be a decendant of DayViewEssentials.
""");
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

    return Container(
      width: _horizontalPositioner.totalWidth,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rowChildren,
        ),
      ),
    );
  }

  Widget _buildStartingOffset() {
    double width = _horizontalPositioner.eventAreaLeft;

    return Container(
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
          dayNumber: dayNumber,
          day: day,
        ),
      );

      if (_horizontalPositioner.isDaySeparationRightOfDay(dayNumber)) {
        int daySeparationNumber =
            _horizontalPositioner.daySeparationNumberRightOfDay(dayNumber);

        daysAndSeparations.add(
          _buildDaySeparation(
            daySeparationNumber: daySeparationNumber,
          ),
        );
      }
    }

    return daysAndSeparations;
  }

  Widget _buildDay({
    @required int dayNumber,
    @required DateTime day,
  }) {
    return Container(
      width: _horizontalPositioner.dayAreaWidth(dayNumber),
      child: widget.headerItemBuilder(context, day),
    );
  }

  Widget _buildDaySeparation({
    @required int daySeparationNumber,
  }) {
    return Container(
      width: _horizontalPositioner.daySeparationAreaWidth(daySeparationNumber),
    );
  }

  Widget _buildEndingOffset() {
    return Container(
      width: _endingOffsetWidth,
    );
  }

  double get _endingOffsetWidth =>
      _horizontalPositioner.endMainAreaWidth +
      _horizontalPositioner.endTotalAreaWidth;
}

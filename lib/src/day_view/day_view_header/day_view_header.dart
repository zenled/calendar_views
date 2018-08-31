import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayViewHeader extends StatefulWidget {
  DayViewHeader({
    this.verticalAlignment = CrossAxisAlignment.start,
    @required this.itemBuilder,
  })
      : assert(verticalAlignment != null),
        assert(itemBuilder != null);

  final CrossAxisAlignment verticalAlignment;
  final DayViewHeaderItemBuilder itemBuilder;

  @override
  State createState() => new _DayViewHeaderState();
}

class _DayViewHeaderState extends State<DayViewHeader> {
  DayViewEssentials _dayViewEssentials;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dayViewEssentials = DayViewEssentials.of(context);
  }

  HorizontalPositioner get _horizontalPositioner =>
      _dayViewEssentials.horizontalPositioner;

  List<DateTime> get _days => _dayViewEssentials.properties.days;

  int get _numberOfDays => _dayViewEssentials.properties.numberOfDays;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = <Widget>[];

    rowChildren.add(_buildStartingOffset());

    for (int dayNumber = 0; dayNumber < _numberOfDays; dayNumber++) {
      DateTime day = _days[dayNumber];

      rowChildren.add(
        _buildDay(context: context, day: day),
      );
      if (_isDaySeparationAfterDay(dayNumber)) {
        rowChildren.add(_buildDaySeparation(context),);
      }
    }

    rowChildren.add(_buildEndingOffset());

    return new Container(
      width: _horizontalPositioner.availableWidth,
      child: new Row(
        crossAxisAlignment: widget.verticalAlignment,
        children: rowChildren,
      ),
    );
  }

  Widget _buildStartingOffset() {
    double width = _horizontalPositioner.eventAreaLeft;

    return new Container(
      width: width,
    );
  }

  Widget _buildDay({
    @required BuildContext context,
    @required DateTime day,
  }) {
    return new Container(
      width: _horizontalPositioner.dayAreaWidth,
      child: widget.itemBuilder(context, day),
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
    return dayNumber == (_numberOfDays -1) ;
  }

  Widget _buildDaySeparation(BuildContext context) {
    return new Container(
      width: _horizontalPositioner.daySeparationAreaWidth,
    );
  }

  Widget _buildEndingOffset() {
    return new Container(
      width: _endingOffsetWidth,
    );
  }

  double get _endingOffsetWidth =>
      _horizontalPositioner.widths.eventAreaEndMargin +
          _horizontalPositioner.widths.paddingEnd;
}

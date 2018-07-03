import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';
import 'day_header_builder.dart';
import '_day_maker.dart';
import '_day_separation_maker.dart';

@immutable
class OneTimeMaker {
  OneTimeMaker({
    @required this.context,
    @required this.positioningAssistant,
    @required this.days,
    @required this.verticalAlignment,
    @required this.extendOverDaySeparation,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.items,
    @required this.itemBuilder,
  });

  final BuildContext context;

  final PositioningAssistant positioningAssistant;

  final Days days;

  final CrossAxisAlignment verticalAlignment;

  final bool extendOverDaySeparation;

  final bool extendOverEventsAreaStartMargin;

  final bool extendOverEventsAreaEndMargin;

  final List<Widget> items;

  final DayHeaderBuilder itemBuilder;

  Widget make() {
    return new Container(
      width: positioningAssistant.totalAreaWidth,
      child: new Row(
        crossAxisAlignment: verticalAlignment,
        children: _makeRowChildren(),
      ),
    );
  }

  List<Widget> _makeRowChildren() {
    List<Widget> rowChildren = <Widget>[];

    rowChildren.add(
      _buildStartPadding(),
    );

    rowChildren.addAll(
      _buildDaysAndSeparations(),
    );

    rowChildren.add(
      _buildEndPadding(),
    );

    return rowChildren;
  }

  Widget _buildStartPadding() {
    double width = 0.0;
    width += positioningAssistant.contentAreaLeft;
    if (!extendOverEventsAreaStartMargin) {
      width += positioningAssistant.dimensions.eventsAreaStartMargin;
    }

    return new Container(
      width: width,
    );
  }

  List<Widget> _buildDaysAndSeparations() {
    List<Widget> daysAndSeparations = <Widget>[];

    for (int dayNumber in days.dayNumbers) {
      DateTime date = days.getDate(dayNumber);
      int separationNumberBefore = days.separationNumberBefore(dayNumber);
      int separationNumberAfter = days.separationNumberAfter(dayNumber);

      daysAndSeparations.add(
        _buildDay(
          dayNumber: dayNumber,
          date: date,
          separationNumberBefore: separationNumberBefore,
          separationNumberAfter: separationNumberAfter,
        ),
      );

      if (separationNumberAfter != null) {
        daysAndSeparations.add(
          _buildSeparation(separationNumber: separationNumberAfter),
        );
      }
    }

    return daysAndSeparations;
  }

  Widget _buildEndPadding() {
    double width = 0.0;
    if (!extendOverEventsAreaEndMargin) {
      width += positioningAssistant.dimensions.eventsAreaEndMargin;
    }

    return new Container(
      width: width,
    );
  }

  Widget _buildDay({
    @required int dayNumber,
    @required DateTime date,
    @required int separationNumberBefore,
    @required int separationNumberAfter,
  }) {
    DayMaker dayHeaderMaker = new DayMaker(
      context: context,
      positioningAssistant: positioningAssistant,
      days: days,
      extendOverSeparation: extendOverDaySeparation,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      dayNumber: dayNumber,
      date: date,
      separationNumberBefore: separationNumberBefore,
      separationNumberAfter: separationNumberAfter,
      item: _getItem(dayNumber),
      itemBuilder: _getItemBuilder(),
    );

    return dayHeaderMaker.make();
  }

  Widget _buildSeparation({
    @required int separationNumber,
  }) {
    DaySeparationMaker separationMaker = new DaySeparationMaker(
      positioningAssistant: positioningAssistant,
      extendOverDaySeparation: extendOverDaySeparation,
      separationNumber: separationNumber,
    );

    return separationMaker.make();
  }

  Widget _getItem(int dayNumber) {
    if (items != null) {
      return items[dayNumber];
    } else {
      return null;
    }
  }

  DayHeaderBuilder _getItemBuilder() {
    return itemBuilder;
  }
}

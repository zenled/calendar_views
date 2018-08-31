import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '_day_builder.dart';
import '_day_separation_builder.dart';

import 'days_header_item_builder.dart';

@immutable
class OneTimeBuilder {
  OneTimeBuilder({
    @required this.context,
    @required this.positioningAssistant,
    @required this.daysData,
    @required this.verticalAlignment,
    @required this.extendOverDaySeparation,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.items,
    @required this.itemBuilder,
  });

  final BuildContext context;

  final PositioningAssistant positioningAssistant;

  final DaysData daysData;

  final CrossAxisAlignment verticalAlignment;

  final bool extendOverDaySeparation;

  final bool extendOverEventsAreaStartMargin;

  final bool extendOverEventsAreaEndMargin;

  final List<Widget> items;

  final DaysHeaderItemBuilder itemBuilder;

  Widget build() {
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
      width += positioningAssistant.dimensionsData.eventsAreaStartMargin;
    }

    return new Container(
      width: width,
    );
  }

  List<Widget> _buildDaysAndSeparations() {
    List<Widget> daysAndSeparations = <Widget>[];

    for (int dayNumber in daysData.dayNumbers) {
      DateTime day = daysData.dayOf(dayNumber);
      int separationNumberBefore = daysData.daySeparatorNumberBefore(dayNumber);
      int separationNumberAfter = daysData.daySeparatorNumberAfter(dayNumber);

      if (separationNumberBefore != null) {
        daysAndSeparations.add(
          _buildDaySeparation(separationNumberBefore),
        );
      }

      daysAndSeparations.add(
        _buildDay(
          dayNumber: dayNumber,
          day: day,
          separationNumberBefore: separationNumberBefore,
          separationNumberAfter: separationNumberAfter,
        ),
      );

      if (separationNumberAfter != null) {
        daysAndSeparations.add(
          _buildDaySeparation(separationNumberAfter),
        );
      }
    }

    return daysAndSeparations;
  }

  Widget _buildEndPadding() {
    double width = 0.0;
    if (!extendOverEventsAreaEndMargin) {
      width += positioningAssistant.dimensionsData.eventsAreaEndMargin;
    }

    return new Container(
      width: width,
    );
  }

  Widget _buildDay({
    @required int dayNumber,
    @required DateTime day,
    @required int separationNumberBefore,
    @required int separationNumberAfter,
  }) {
    DayBuilder dayBuilder = new DayBuilder(
      context: context,
      day: day,
      item: _getItem(dayNumber),
      itemBuilder: itemBuilder,
      dayWidth: positioningAssistant.dayAreaWidth(dayNumber),
      extendOverSeparation: extendOverDaySeparation,
      separationBeforeWidth: separationNumberBefore != null
          ? positioningAssistant
                  .daySeparationAreaWidth(separationNumberBefore) /
              2
          : 0.0,
      separationAfterWidth: separationNumberAfter != null
          ? positioningAssistant.daySeparationAreaWidth(separationNumberAfter) /
              2
          : 0.0,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      isFirstDay: dayNumber == 0,
      isLastDay: dayNumber == (daysData.numberOfDays - 1),
      eventsAreaStartMarginWidth:
          positioningAssistant.dimensionsData.eventsAreaStartMargin,
      eventsAreaEndMarginWidth:
          positioningAssistant.dimensionsData.eventsAreaEndMargin,
    );

    return dayBuilder.build();
  }

  Widget _buildDaySeparation(int separationNumber) {
    DaySeparationBuilder separationBuilder = new DaySeparationBuilder(
      extendOverSeparation: extendOverDaySeparation,
      separationWidth: _getDaySeparationWidth(separationNumber) / 2,
    );

    return separationBuilder.build();
  }

  Widget _getItem(int dayNumber) {
    if (items != null) {
      return items[dayNumber];
    } else {
      return null;
    }
  }

  double _getDaySeparationWidth(int separationNumber) {
    return positioningAssistant.daySeparationAreaWidth(separationNumber);
  }
}

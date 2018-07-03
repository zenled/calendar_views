import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import 'days_header.dart';

@immutable
class DayMaker {
  DayMaker({
    @required this.context,
    @required this.positioningAssistant,
    @required this.days,
    @required this.extendOverSeparation,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.dayNumber,
    @required this.date,
    @required this.separationNumberBefore,
    @required this.separationNumberAfter,
    @required this.item,
    @required this.itemBuilder,
  });

  final BuildContext context;

  final PositioningAssistant positioningAssistant;

  final Days days;

  final bool extendOverSeparation;

  final bool extendOverEventsAreaStartMargin;

  final bool extendOverEventsAreaEndMargin;

  final int dayNumber;

  final DateTime date;

  final int separationNumberBefore;

  final int separationNumberAfter;

  final Widget item;

  final DayHeaderBuilder itemBuilder;

  Widget make() {
    if (item != null) {
      return _makeFromItem();
    } else {
      return _makeFromBuilder();
    }
  }

  Widget _makeFromItem() {
    return _buildContainer(
      child: item,
    );
  }

  Widget _makeFromBuilder() {
    return _buildContainer(
      child: _buildItem(),
    );
  }

  Widget _buildItem() {
    return itemBuilder(
      context: context,
      date: date,
    );
  }

  Container _buildContainer({
    @required Widget child,
  }) {
    return new Container(
      width: _calculateContainerWidth(),
      child: child,
    );
  }

  double _calculateContainerWidth() {
    double width = 0.0;

    // eventsAreaStartMargin
    if (dayNumber == 0 && extendOverEventsAreaStartMargin) {
      width += positioningAssistant.dimensions.eventsAreaStartMargin;
    }

    // separation before
    if (separationNumberBefore != null && extendOverSeparation) {
      double separationBeforeWidth =
          positioningAssistant.daySeparationAreaWidth(separationNumberBefore) /
              2;

      width += separationBeforeWidth;
    }

    // day area
    width += positioningAssistant.dayAreaWidth(dayNumber);

    // separation after
    if (separationNumberAfter != null && extendOverSeparation) {
      double separationAfterWidth =
          positioningAssistant.daySeparationAreaWidth(separationNumberAfter) /
              2;

      width += separationAfterWidth;
    }

    // eventsAreaEndMargin
    if (dayNumber == (days.numberOfDays - 1) && extendOverEventsAreaEndMargin) {
      width += positioningAssistant.dimensions.eventsAreaEndMargin;
    }

    return width;
  }
}

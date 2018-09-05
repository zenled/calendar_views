import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days_header_item_builder.dart';

@immutable
class DayBuilder {
  DayBuilder({
    @required this.context,
    @required this.day,
    @required this.item,
    @required this.itemBuilder,
    @required this.dayWidth,
    @required this.extendOverSeparation,
    @required this.separationBeforeWidth,
    @required this.separationAfterWidth,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.isFirstDay,
    @required this.isLastDay,
    @required this.eventsAreaStartMarginWidth,
    @required this.eventsAreaEndMarginWidth,
  })  : assert(context != null),
        assert(day != null),
        assert(dayWidth != null),
        assert(extendOverSeparation != null),
        assert(separationBeforeWidth != null),
        assert(separationAfterWidth != null),
        assert(extendOverEventsAreaStartMargin != null),
        assert(extendOverEventsAreaEndMargin != null),
        assert(isFirstDay != null),
        assert(isLastDay != null),
        assert(eventsAreaStartMarginWidth != null),
        assert(eventsAreaEndMarginWidth != null);

  final BuildContext context;

  final DateTime day;

  final Widget item;
  final DaysHeaderItemBuilder itemBuilder;

  final double dayWidth;

  final bool extendOverSeparation;
  final double separationBeforeWidth;
  final double separationAfterWidth;

  final bool extendOverEventsAreaStartMargin;
  final bool extendOverEventsAreaEndMargin;
  final bool isFirstDay;
  final bool isLastDay;
  final double eventsAreaStartMarginWidth;
  final double eventsAreaEndMarginWidth;

  Widget build() {
    return _buildContainer(
      child: _getItem(),
    );
  }

  Container _buildContainer({
    @required Widget child,
  }) {
    assert(child != null);

    return new Container(
      width: _calculateContainerWidth(),
      child: child,
    );
  }

  Widget _getItem() {
    if (item != null) {
      return item;
    } else {
      return itemBuilder(context, day);
    }
  }

  double _calculateContainerWidth() {
    double width = 0.0;

    // eventsAreaStartMargin
    if (isFirstDay && extendOverEventsAreaStartMargin) {
      width += eventsAreaStartMarginWidth;
    }

    // separation before
    if (extendOverSeparation) {
      width += separationBeforeWidth;
    }

    // day
    width += dayWidth;

    // separation after
    if (extendOverSeparation) {
      width += separationAfterWidth;
    }

    // eventsAreaEndMargin
    if (isLastDay && extendOverEventsAreaEndMargin) {
      width += eventsAreaEndMarginWidth;
    }

    return width;
  }
}

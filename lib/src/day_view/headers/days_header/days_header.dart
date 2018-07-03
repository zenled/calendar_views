import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import 'day_header_builder.dart';
import '_one_time_maker.dart';

export 'day_header_builder.dart';

class DaysHeader extends StatefulWidget {
  DaysHeader._internal({
    @required this.verticalAlignment,
    @required this.extendOverDaySeparation,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.headerItems,
    @required this.headerBuilder,
  })  : assert(verticalAlignment != null),
        assert(extendOverDaySeparation != null),
        assert(extendOverEventsAreaStartMargin != null),
        assert(extendOverEventsAreaEndMargin != null),
        assert(headerItems != null || headerBuilder != null);

  factory DaysHeader({
    CrossAxisAlignment verticalAlignment = CrossAxisAlignment.start,
    bool extendOverDaySeparation = true,
    bool extendOverEventsAreaStartMargin = true,
    bool extendOverEventsAreaEndMargin = true,
    @required List<Widget> headerItems,
  }) {
    return DaysHeader._internal(
      verticalAlignment: verticalAlignment,
      extendOverDaySeparation: extendOverDaySeparation,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      headerItems: headerItems,
      headerBuilder: null,
    );
  }

  factory DaysHeader.builder({
    CrossAxisAlignment verticalAlignment = CrossAxisAlignment.start,
    bool extendOverDaySeparation = true,
    bool extendOverEventsAreaStartMargin = true,
    bool extendOverEventsAreaEndMargin = true,
    @required DayHeaderBuilder headerBuilder,
  }) {
    return DaysHeader._internal(
      verticalAlignment: verticalAlignment,
      extendOverDaySeparation: extendOverDaySeparation,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      headerItems: null,
      headerBuilder: headerBuilder,
    );
  }

  final CrossAxisAlignment verticalAlignment;

  final bool extendOverDaySeparation;

  final bool extendOverEventsAreaStartMargin;

  final bool extendOverEventsAreaEndMargin;

  final List<Widget> headerItems;

  final DayHeaderBuilder headerBuilder;

  @override
  _DaysHeaderState createState() => new _DaysHeaderState();
}

class _DaysHeaderState extends State<DaysHeader> {
  PositioningAssistant _getPositioningAssistant() {
    return PositioningAssistantProvider.of(context);
  }

  Days _getDays() {
    return DaysProvider.of(context);
  }

  void _throwArgumentErrorIfInvalidNumberOfHeaderItems(Days days) {
    if (widget.headerItems != null) {
      if (widget.headerItems.length != days.numberOfDays) {
        throw new ArgumentError(
          "Number of header items must be the same as number of days in a DayView.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PositioningAssistant positioningAssistant = _getPositioningAssistant();
    Days days = _getDays();

    _throwArgumentErrorIfInvalidNumberOfHeaderItems(days);

    OneTimeMaker oneTimeMaker = new OneTimeMaker(
      context: context,
      positioningAssistant: positioningAssistant,
      days: days,
      verticalAlignment: widget.verticalAlignment,
      extendOverDaySeparation: widget.extendOverDaySeparation,
      extendOverEventsAreaStartMargin: widget.extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: widget.extendOverEventsAreaEndMargin,
      items: widget.headerItems,
      itemBuilder: widget.headerBuilder,
    );

    return oneTimeMaker.make();
  }
}

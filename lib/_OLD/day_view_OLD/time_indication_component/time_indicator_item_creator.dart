import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/positioning_assistant.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../item_position.dart';
import '../item_size.dart';
import 'time_indicator_item_builder.dart';
import 'time_indicator_properties.dart';

class TimeIndicatorItemCreator {
  TimeIndicatorItemCreator({
    @required this.context,
    @required this.restrictions,
    @required this.positioningAssistant,
    @required this.builder,
  })  : assert(context != null),
        assert(restrictions != null),
        assert(positioningAssistant != null),
        assert(builder != null);

  final BuildContext context;

  final RestrictionsData restrictions;
  final PositioningAssistant positioningAssistant;
  final TimeIndicatorItemBuilder builder;

  bool wouldItemBeVisible(int minuteOfDay) {
    return minuteOfDay >= restrictions.minimumMinuteOfDay &&
        minuteOfDay <= restrictions.maximumMinuteOfDay;
  }

  Positioned createItem({
    @required TimeIndicatorProperties itemProperties,
  }) {
    return builder(
      context: context,
      position: _positionOf(
        minuteOfDay: itemProperties.minuteOfDay,
        duration: itemProperties.duration,
      ),
      size: _sizeOf(
        minutes: itemProperties.duration,
      ),
      properties: itemProperties,
    );
  }

  ItemPosition _positionOf({
    @required int minuteOfDay,
    @required int duration,
  }) {
    return new ItemPosition(
      top: positioningAssistant.minuteOfDayFromTopInsideTimeIndicationArea(
            minuteOfDay - (duration ~/ 2),
          ) +
          positioningAssistant.timeIndicationAreaTop,
      left: positioningAssistant.timeIndicationAreaLeft,
    );
  }

  ItemSize _sizeOf({
    @required int minutes,
  }) {
    return new ItemSize(
      width: positioningAssistant.timeIndicationAreaWidth,
      height: positioningAssistant.heightOfDuration(minutes),
    );
  }
}

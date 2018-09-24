import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/positioning_assistant.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../item_position.dart';
import 'support_line_item_builder.dart';
import 'support_line_properties.dart';

@immutable
class SupportLineItemCreator {
  SupportLineItemCreator({
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
  final SupportLineItemBuilder builder;

  bool wouldItemBeVisible(int minuteOfDay) {
    return minuteOfDay >= restrictions.minimumMinuteOfDay &&
        minuteOfDay <= restrictions.maximumMinuteOfDay;
  }

  Positioned createItem({
    @required SupportLineProperties itemProperties,
  }) {
    return builder(
      context: context,
      position: _positionOf(itemProperties.minuteOfDay),
      width: _itemWidth,
      properties: itemProperties,
    );
  }

  ItemPosition _positionOf(int minuteOfDay) {
    return new ItemPosition(
      top: positioningAssistant
              .minuteOfDayFromTopInsideContentArea(minuteOfDay) +
          positioningAssistant.contentAreaTop,
      left: positioningAssistant.mainAreaLeft,
    );
  }

  double get _itemWidth => positioningAssistant.mainAreaWidth;
}

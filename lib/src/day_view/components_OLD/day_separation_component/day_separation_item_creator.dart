import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/positioning_assistant.dart';

import '../item_position.dart';
import '../item_size.dart';
import 'day_separation_item_builder.dart';
import 'day_separation_properties.dart';

class DaySeparationItemCreator {
  DaySeparationItemCreator({
    @required this.context,
    @required this.positioningAssistant,
    @required this.useExtendedDaySeparation,
    @required this.builder,
  })  : assert(context != null),
        assert(positioningAssistant != null),
        assert(useExtendedDaySeparation != null),
        assert(builder != null);

  BuildContext context;
  PositioningAssistant positioningAssistant;
  bool useExtendedDaySeparation;
  DaySeparationItemBuilder builder;

  Positioned createItem(DaySeparationProperties itemProperties) {
    int daySeparationNumber = itemProperties.daySeparationNumber;

    return builder(
      context: context,
      position: _positionOf(daySeparationNumber),
      size: _sizeOf(daySeparationNumber),
      properties: itemProperties,
    );
  }

  ItemPosition _positionOf(int daySeparationNumber) {
    if (useExtendedDaySeparation) {
      return _extendedPositionOf(daySeparationNumber);
    } else {
      return _nonExtendedPositionOf(daySeparationNumber);
    }
  }

  ItemSize _sizeOf(int daySeparationNumber) {
    if (useExtendedDaySeparation) {
      return _extendedSizeOf(daySeparationNumber);
    } else {
      return _nonExtendedSizeOf(daySeparationNumber);
    }
  }

  ItemPosition _nonExtendedPositionOf(int daySeparationNumber) {
    return new ItemPosition(
      top: positioningAssistant.daySeparationAreaTop(daySeparationNumber),
      left: positioningAssistant.daySeparationAreaLeft(daySeparationNumber),
    );
  }

  ItemPosition _extendedPositionOf(int daySeparationNumber) {
    return new ItemPosition(
      top: positioningAssistant
          .extendedDaySeparationAreaTop(daySeparationNumber),
      left: positioningAssistant
          .extendedDaySeparationAreaLeft(daySeparationNumber),
    );
  }

  ItemSize _nonExtendedSizeOf(int daySeparationNumber) {
    return new ItemSize(
      width: positioningAssistant.daySeparationAreaWidth(daySeparationNumber),
      height: positioningAssistant.daySeparationAreaHeight(daySeparationNumber),
    );
  }

  ItemSize _extendedSizeOf(int daySeparationNumber) {
    return new ItemSize(
      width: positioningAssistant
          .extendedDaySeparationAreaWidth(daySeparationNumber),
      height: positioningAssistant
          .extendedDaySeparationAreaHeight(daySeparationNumber),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../day_view_component.dart';
import 'time_indicator_item_builder.dart';
import 'time_indicator_item_creator.dart';
import 'time_indicator_properties.dart';

class CustomTimeIndicationComponent implements DayViewComponent {
  const CustomTimeIndicationComponent({
    @required this.timeIndicatorsToMake,
    @required this.itemBuilder,
  })  : assert(timeIndicatorsToMake != null),
        assert(itemBuilder != null);

  /// List of TimeIndicators ([TimeIndicatorProperties]) to build when calling [buildItems].
  final List<TimeIndicatorProperties> timeIndicatorsToMake;

  /// Function that builds a TimeIndicator.
  final TimeIndicatorItemBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> builtItems = <Positioned>[];

    TimeIndicatorItemCreator itemCreator = new TimeIndicatorItemCreator(
      context: context,
      restrictions: _getRestrictions(context),
      positioningAssistant: _getPositioningAssistant(context),
      builder: itemBuilder,
    );

    for (TimeIndicatorProperties itemProperties in timeIndicatorsToMake) {
      if (!itemCreator.wouldItemBeVisible(itemProperties.minuteOfDay)) {
        continue;
      }

      builtItems.add(
        itemCreator.createItem(
          itemProperties: itemProperties,
        ),
      );
    }

    return builtItems;
  }

  Restrictions _getRestrictions(BuildContext context) {
    return RestrictionsProvider.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

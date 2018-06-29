import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../day_view_component.dart';
import 'support_line_builder.dart';
import 'support_line_item_creator.dart';
import 'support_line_properties.dart';

class CustomSupportLineComponent extends DayViewComponent {
  const CustomSupportLineComponent({
    @required this.supportLinesToBuild,
    this.itemBuilder = defaultSupportLineBuilder,
  })  : assert(supportLinesToBuild != null),
        assert(itemBuilder != null);

  /// List of SupportLines ([SupportLineProperties]) to build when calling [buildItems].
  final List<SupportLineProperties> supportLinesToBuild;

  /// Function that builds a SupportLine.
  final SupportLineItemBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    SupportLineItemCreator itemCreator = new SupportLineItemCreator(
      context: context,
      restrictions: _getRestrictions(context),
      positioningAssistant: _getPositioningAssistant(context),
      builder: itemBuilder,
    );

    List<Positioned> items = <Positioned>[];

    for (SupportLineProperties itemProperties in supportLinesToBuild) {
      if (!itemCreator.wouldItemBeVisible(itemProperties.minuteOfDay)) {
        continue;
      }

      items.add(
        itemCreator.createItem(
          itemProperties: itemProperties,
        ),
      );
    }

    return items;
  }

  Restrictions _getRestrictions(BuildContext context) {
    return RestrictionsProvider.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

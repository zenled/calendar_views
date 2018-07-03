import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../component.dart';
import 'day_separation_item_builder.dart';
import 'day_separation_item_creator.dart';
import 'day_separation_properties.dart';

class DaySeparationComponent extends Component {
  DaySeparationComponent({
    this.useExtendedDaySeparation = true,
    this.itemBuilder = defaultDaySeparationBuilder,
  })  : assert(useExtendedDaySeparation != null),
        assert(itemBuilder != null);

  final DaySeparationItemBuilder itemBuilder;

  final bool useExtendedDaySeparation;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    DaySeparationItemCreator itemCreator = new DaySeparationItemCreator(
      context: context,
      positioningAssistant: _getPositioningAssistant(context),
      useExtendedDaySeparation: useExtendedDaySeparation,
      builder: itemBuilder,
    );

    for (int daySeparationNumber in _getDaySeparationNumbers(context)) {
      DaySeparationProperties itemProperties = _createItemProperties(
        daySeparationNumber: daySeparationNumber,
      );

      items.add(
        itemCreator.createItem(itemProperties),
      );
    }

    return items;
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }

  List<int> _getDaySeparationNumbers(BuildContext context) {
    return DaysProvider.of(context).daySeparationNumbers;
  }

  DaySeparationProperties _createItemProperties({
    @required int daySeparationNumber,
  }) {
    return new DaySeparationProperties(
      daySeparationNumber: daySeparationNumber,
    );
  }
}

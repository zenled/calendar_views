import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/calendar_items/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import '../day_view_component.dart';
import 'support_line_item_creator.dart';
import 'support_line_item_builder.dart';
import 'support_line_properties.dart';

/// [DayViewComponent] that builds SupportLines at specific [interval]s starting at [minuteOfDayOfFirstSupportLine].
class IntervalSupportLineComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a SupportLine every [interval] minutes starting at [minuteOfDayOfFirstSupportLine].
  const IntervalSupportLineComponent({
    this.minuteOfDayOfFirstSupportLine = 0,
    @required this.interval,
    this.itemBuilder = defaultSupportLineBuilder,
  })  : assert(minuteOfDayOfFirstSupportLine != null &&
            minuteOfDayOfFirstSupportLine >= utils.minimum_minute_of_day &&
            minuteOfDayOfFirstSupportLine <= utils.maximum_minute_of_day),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a SupportLine for every full hour.
  factory IntervalSupportLineComponent.everyHour({
    SupportLineItemBuilder itemBuilder,
  }) {
    if (itemBuilder != null) {
      return new IntervalSupportLineComponent(
        interval: 60,
        itemBuilder: itemBuilder,
      );
    } else {
      return new IntervalSupportLineComponent(
        interval: 60,
      );
    }
  }

  /// Minute of day of first Support line.
  final int minuteOfDayOfFirstSupportLine;

  /// Minutes between SupportLines.
  final int interval;

  /// Function that builds a SupportLine.
  final SupportLineItemBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    Restrictions restrictions = _getRestrictions(context);

    PositioningAssistant positioningAssistant =
        _getPositioningAssistant(context);

    SupportLineItemCreator itemCreator = new SupportLineItemCreator(
      context: context,
      restrictions: restrictions,
      positioningAssistant: positioningAssistant,
      builder: itemBuilder,
    );

    List<Positioned> builtItems = <Positioned>[];

    for (int minuteOfDay = minuteOfDayOfFirstSupportLine;
        minuteOfDay <= restrictions.maximumMinuteOfDay;
        minuteOfDay += interval) {
      if (!itemCreator.wouldItemBeVisible(minuteOfDay)) {
        continue;
      }

      builtItems.add(
        itemCreator.createItem(
          itemProperties:
              _createSupportLineProperties(minuteOfDay: minuteOfDay),
        ),
      );
    }

    return builtItems;
  }

  SupportLineProperties _createSupportLineProperties({
    @required int minuteOfDay,
  }) {
    return new SupportLineProperties(
      minuteOfDay: minuteOfDay,
    );
  }

  Restrictions _getRestrictions(BuildContext context) {
    return RestrictionsProvider.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

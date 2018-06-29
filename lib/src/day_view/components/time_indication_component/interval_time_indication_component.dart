import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import '../day_view_component.dart';
import 'time_indicator_item_builder.dart';
import 'time_indicator_item_creator.dart';
import 'time_indicator_properties.dart';

/// [DayViewComponent] that builds TimeIndicators at specific [interval]s starting at [minuteOfDayOfFirstTimeIndicator].
@immutable
class IntervalTimeIndicationComponent implements DayViewComponent {
  /// Creates a [DayViewComponent] that builds a TimeIndicator every [interval] minutes starting at [minuteOfDayOfFirstTimeIndicator].
  const IntervalTimeIndicationComponent({
    this.minuteOfDayOfFirstTimeIndicator = 0,
    @required this.interval,
    this.itemBuilder = defaultTimeIndicatorBuilder,
  })  : assert(minuteOfDayOfFirstTimeIndicator != null &&
            minuteOfDayOfFirstTimeIndicator >= utils.minimum_minute_of_day &&
            minuteOfDayOfFirstTimeIndicator <= utils.maximum_minute_of_day),
        assert(interval != null && interval > 0),
        assert(itemBuilder != null);

  /// Creates a [DayViewComponent] that builds a TimeIndicator for every full hour.
  factory IntervalTimeIndicationComponent.everyHour({
    TimeIndicatorItemBuilder itemBuilder,
  }) {
    if (itemBuilder != null) {
      return new IntervalTimeIndicationComponent(
        interval: 60,
        itemBuilder: itemBuilder,
      );
    } else {
      return new IntervalTimeIndicationComponent(
        interval: 60,
      );
    }
  }

  /// Minute of day of first TimeIndicator.
  final int minuteOfDayOfFirstTimeIndicator;

  /// Minutes between TimeIndicators.
  final int interval;

  /// Function that builds a TimeIndicator.
  final TimeIndicatorItemBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> builtItems = <Positioned>[];

    Restrictions restrictions = _getRestrictions(context);

    PositioningAssistant positioningAssistant =
        _getPositioningAssistant(context);

    TimeIndicatorItemCreator itemCreator = new TimeIndicatorItemCreator(
      context: context,
      restrictions: restrictions,
      positioningAssistant: positioningAssistant,
      builder: itemBuilder,
    );

    for (int minuteOfDay = minuteOfDayOfFirstTimeIndicator;
        minuteOfDay <= restrictions.maximumMinuteOfDay;
        minuteOfDay += interval) {
      if (!itemCreator.wouldItemBeVisible(minuteOfDay)) {
        continue;
      }

      builtItems.add(
        itemCreator.createItem(
          itemProperties: _createTimeIndicatorProperties(
            minuteOfDay: minuteOfDay,
          ),
        ),
      );
    }

    return builtItems;
  }

  TimeIndicatorProperties _createTimeIndicatorProperties({
    @required int minuteOfDay,
  }) {
    return new TimeIndicatorProperties(
      minuteOfDay: minuteOfDay,
      duration: interval,
    );
  }

  Restrictions _getRestrictions(BuildContext context) {
    return RestrictionsProvider.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../component.dart';
import '_single_day_events_items_creator/single_day_event_items_creator.dart';
import 'event_item_builder.dart';

/// [Component] that builds events.
class EventViewComponent extends Component {
  /// Creates a [Component] that builds events of a single day.
  const EventViewComponent({
    this.eventsFilter,
    this.eventsArranger = const ChainsEventsArranger(),
    @required this.eventBuilder,
  })  : assert(eventsArranger != null),
        assert(eventBuilder != null);

  /// Item that tells this component if certain event should be shown.
  final EventsFilter eventsFilter;

  /// Object that arranges the events.
  final EventsArranger eventsArranger;

  /// Function that builds an event.
  final EventBuilder eventBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> builtItems = <Positioned>[];

    DaysData daysData = _getDaysData(context);
    RestrictionsData restrictionsData = _getRestrictionsData(context);
    PositioningAssistant positioningAssistant =
        _getPositioningAssistant(context);

    for (int dayNumber in daysData.dayNumbers) {
      DateTime day = daysData.dayOf(dayNumber);

      SingleDayEventItemsCreator itemsCreator = new SingleDayEventItemsCreator(
        context: context,
        day: day,
        builder: eventBuilder,
        restrictions: restrictionsData,
        filter: eventsFilter,
        arranger: eventsArranger,
        area: positioningAssistant.dayArea(dayNumber),
      );

      builtItems.addAll(
        itemsCreator.createItems(),
      );
    }

    return builtItems;
  }

  DaysData _getDaysData(BuildContext context) {
    return Days.of(context);
  }

  RestrictionsData _getRestrictionsData(BuildContext context) {
    return Restrictions.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

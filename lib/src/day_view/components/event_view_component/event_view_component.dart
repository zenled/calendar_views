import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../component.dart';
import 'single_day_events_items_creator/single_day_event_items_creator.dart';
import 'event_item_builder.dart';

/// [Component] that builds events.
class EventViewComponent extends Component {
  /// Creates a [Component] that builds events of a single day.
  const EventViewComponent({
    this.eventsFilter,
    this.eventsArranger = const ColumnsEventsArranger(),
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

    Restrictions restrictions = _getRestrictions(context);

    PositioningAssistant positioningAssistant =
        _getPositioningAssistant(context);

    Days days = _getDays(context);
    for (int dayNumber in days.dayNumbers) {
      DateTime date = days.getDate(dayNumber);

      SingleDayEventItemsCreator itemsCreator = new SingleDayEventItemsCreator(
        context: context,
        restrictions: restrictions,
        filter: eventsFilter,
        arranger: eventsArranger,
        positioningAssistant: positioningAssistant,
        builder: eventBuilder,
        date: date,
        dayNumber: dayNumber,
      );

      builtItems.addAll(
        itemsCreator.createItems(),
      );
    }

    return builtItems;
  }

  Days _getDays(BuildContext context) {
    return DaysProvider.of(context);
  }

  Restrictions _getRestrictions(BuildContext context) {
    return RestrictionsProvider.of(context);
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}

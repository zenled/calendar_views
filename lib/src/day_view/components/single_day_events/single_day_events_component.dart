import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

import '../../dimensions_positions/all.dart';
import '../../restrictions/all.dart';
import '../../day_view_date.dart';
import '../day_view_component.dart';
import 'single_day_event_builder.dart';

class SingleDayEventsComponent extends DayViewComponent {
  const SingleDayEventsComponent({
    this.eventsArranger = const ExtendedColumnsEventsArranger(),
    @required this.itemBuilder,
  })  : assert(eventsArranger != null),
        assert(itemBuilder != null);

  final EventsArranger eventsArranger;

  final SingleDayEventBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    // retrieves events
    DateTime date = DayViewDate.of(context).date;
    Set<PositionableEvent> events = EventsProvider.of(context).events;

    // extracts visible events (events that will be visible int the DayView)
    int minimumMinuteOfDay = DayViewRestrictions.of(context).minimumMinuteOfDay;
    int maximumMinuteOfDay = DayViewRestrictions.of(context).maximumMinuteOfDay;

    events.retainWhere(
      (PositionableEvent event) =>
          event.beginMinuteOfDay >= minimumMinuteOfDay &&
          (event.beginMinuteOfDay + event.duration) <= maximumMinuteOfDay,
    );

    // arranges events
    DayViewPositions dayViewPositions = DayViewPositions.of(context);

    List<ArrangedEvent> arrangedEvents = eventsArranger.arrangeEvents(
      events: events.toList(),
      constraints: new ArrangerConstraints(
        areaLeft: dayViewPositions.eventAreaLeft,
        areaWidth: dayViewPositions.eventAreaWidth,
        positionTop: dayViewPositions.minuteOfDayTop,
        height: dayViewPositions.heightOfMinutes,
      ),
    );

    // builds events
    for (ArrangedEvent arrangedEvent in arrangedEvents) {
      items.add(
        itemBuilder(
          context: context,
          position: arrangedEvent.position,
          size: arrangedEvent.size,
          event: arrangedEvent.event,
        ),
      );
    }

    return items;
  }
}

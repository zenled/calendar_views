import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/event.dart';

import '_day_builder.dart';

typedef List<TimePositionableEvent> GetEventsOfDayCallback(
  DateTime day,
);

@immutable
class EventViewComponent implements DayViewComponent {
  EventViewComponent({
    @required this.getEventsOfDay,
    this.eventsArranger = const ChainsEventsArranger(),
    @required this.eventItemBuilder,
  });

  final GetEventsOfDayCallback getEventsOfDay;
  final EventsArranger eventsArranger;
  final EventItemBuilder eventItemBuilder;

  @override
  List<Positioned> buildItems({
    @required BuildContext context,
    @required Properties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];
    List<DateTime> days = properties.days;

    for (int i = 0; i < days.length; i++) {
      DateTime day = days[i];
      Area area = positioner.getNumberedArea(AreaName.dayArea, i);
      List<TimePositionableEvent> events = getEventsOfDay(day);

      builtItems.addAll(
        _buildDay(
          context: context,
          events: events,
          area: area,
        ),
      );
    }

    return builtItems;
  }

  List<Positioned> _buildDay({
    @required BuildContext context,
    @required List<TimePositionableEvent> events,
    @required Area area,
  }) {
    DayBuilder dayBuilder = new DayBuilder(
      context: context,
      events: events,
      area: area,
      eventsArranger: eventsArranger,
      eventItemBuilder: eventItemBuilder,
    );
    return dayBuilder.build();
  }
}

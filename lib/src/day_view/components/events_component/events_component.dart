library events_component;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/calendar_items.dart';

import '../day_view_component.dart';
import 'one_time_events_builder/one_time_events_builder.dart';

part 'event_builder.dart';

/// [DayViewComponent] that builds events.
class EventsComponent extends DayViewComponent {
  /// Creates a [DayViewComponent] that builds events of a single day.
  const EventsComponent({
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
    return OneTimeEventsBuilder(
      context: context,
      filter: eventsFilter,
      arranger: eventsArranger,
      builder: eventBuilder,
    ).buildItems();
  }
}

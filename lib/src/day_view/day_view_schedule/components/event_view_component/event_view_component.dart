import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import '_day_builder.dart';

/// Signature for a function that returns events of some [day].
///
/// Properties of [day] except for year, month and day are set to their default values.
typedef Iterable<StartDurationItem> GetEventsOfDayCallback(
  DateTime day,
);

/// [ScheduleComponent] for displaying events in every [DayViewArea.dayArea] of [DayViewSchedule].
@immutable
class EventViewComponent implements ScheduleComponent {
  EventViewComponent({
    @required this.getEventsOfDay,
    this.eventArranger = const ChainsEventArranger(),
  })  : assert(getEventsOfDay != null),
        assert(eventArranger != null);

  /// Function that returns events of some day.
  final GetEventsOfDayCallback getEventsOfDay;

  /// Objects that determines positions and sizes of events displayed by this component.
  final EventViewArranger eventArranger;

  @override
  List<Positioned> buildItems(
    BuildContext context,
    DayViewProperties properties,
    SchedulePositioner positioner,
  ) {
    List<Positioned> items = <Positioned>[];

    List<DateTime> days = properties.days;
    for (int dayNumber = 0; dayNumber < days.length; dayNumber++) {
      DateTime day = days[dayNumber];

      List<Positioned> itemsOfDay = _buildDay(
        context: context,
        dayNumber: dayNumber,
        events: getEventsOfDay(day),
        positioner: positioner,
      );

      items.addAll(itemsOfDay);
    }

    return items;
  }

  List<Positioned> _buildDay({
    @required BuildContext context,
    @required int dayNumber,
    @required Iterable<StartDurationItem> events,
    @required SchedulePositioner positioner,
  }) {
    DayBuilder dayBuilder = new DayBuilder(
      context: context,
      dayNumber: dayNumber,
      events: events,
      eventArranger: eventArranger,
      positioner: positioner,
    );

    return dayBuilder.build();
  }
}

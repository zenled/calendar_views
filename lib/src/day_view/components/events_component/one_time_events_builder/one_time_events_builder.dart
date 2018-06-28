library one_time_events_builder;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positions/positions.dart';
import 'package:calendar_views/src/day_view/restrictions/restrictions.dart';
import 'package:calendar_views/src/day_view/day_view_dates.dart';
import 'package:calendar_views/calendar_items.dart';

import '../events_component.dart';

part '_single_date_events_preparer.dart';

part '_single_date_events_builder.dart';

class OneTimeEventsBuilder {
  OneTimeEventsBuilder._internal({
    @required this.context,
    @required this.dates,
    @required this.filter,
    @required this.arranger,
    @required this.positioner,
    @required this.builder,
  });

  factory OneTimeEventsBuilder({
    @required BuildContext context,
    @required EventsFilter filter,
    @required EventsArranger arranger,
    @required EventBuilder builder,
  }) {
    return new OneTimeEventsBuilder._internal(
      context: context,
      dates: _getDates(context),
      filter: filter,
      arranger: arranger,
      positioner: _getPositioner(context),
      builder: builder,
    );
  }

  final BuildContext context;

  final List<DateTime> dates;

  final EventsFilter filter;
  final EventsArranger arranger;
  final DayViewPositioner positioner;
  final EventBuilder builder;

  List<Positioned> buildItems() {
    List<Positioned> items = <Positioned>[];

    for (int dayNumber = 0; dayNumber < dates.length; dayNumber++) {
      DateTime date = dates[dayNumber];

      Set<PositionableEvent> eventsOfDate = _getEventsOfDate(date);
      List<Positioned> builtEvents = _buildEvents(dayNumber, eventsOfDate);

      items.addAll(builtEvents);
    }

    return items;
  }

  Set<PositionableEvent> _getEventsOfDate(DateTime date) {
    return new _SingleDateEventsPreparer(
      context: context,
      date: date,
      eventsFilter: filter,
    ).getAndPrepareEvents();
  }

  List<Positioned> _buildEvents(int dayNumber, Set<PositionableEvent> events) {
    return new _SingleDateEventsBuilder(
      context: context,
      dayNumber: dayNumber,
      arranger: arranger,
      positioner: positioner,
      itemBuilder: builder,
      events: events,
    ).buildEvents();
  }
}

List<DateTime> _getDates(BuildContext context) {
  return DayViewDates.of(context).dates;
}

DayViewPositioner _getPositioner(BuildContext context) {
  return DayViewPositionerGenerator.of(context).createPositioner(context);
}

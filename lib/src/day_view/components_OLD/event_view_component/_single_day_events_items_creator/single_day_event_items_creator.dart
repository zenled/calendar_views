import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import '../../item_position.dart';
import '../../item_size.dart';
import '../event_item_builder.dart';

import 'single_day_events_preparer.dart';

class SingleDayEventItemsCreator {
  SingleDayEventItemsCreator({
    @required this.context,
    @required this.day,
    @required this.builder,
    @required this.restrictions,
    @required this.filter,
    @required this.arranger,
    @required this.area,
  })  : assert(context != null),
        assert(day != null),
        assert(builder != null),
        assert(restrictions != null),
        assert(arranger != null),
        assert(area != null);

  final BuildContext context;

  final DateTime day;
  final EventBuilder builder;

  final RestrictionsData restrictions;
  final EventsFilter filter;
  final EventsArranger arranger;
  final AreaOLD area;

  List<Positioned> createItems() {
    Set<PositionableEvent> events = _getEvents();
    List<ArrangedEvent> arrangedEvents = _arrangeEvents(events);
    return _buildArrangedEvents(arrangedEvents);
  }

  Set<PositionableEvent> _getEvents() {
    SingleDayEventsPreparer eventsPreparer = new SingleDayEventsPreparer(
      day: day,
      context: context,
      restrictions: restrictions,
      filter: filter,
    );

    return eventsPreparer.getAndPrepareEvents();
  }

  List<ArrangedEvent> _arrangeEvents(Set<PositionableEvent> events) {
    return arranger.arrangeEvents(
      constraints: _makeArrangerConstraints(),
      events: events,
    );
  }

  List<Positioned> _buildArrangedEvents(List<ArrangedEvent> events) {
    return events
        .map(
          (arrangedEvent) => builder(
                context: context,
                position: _makeItemPosition(arrangedEvent),
                size: _makeItemSize(arrangedEvent),
                event: arrangedEvent.event,
              ),
        )
        .toList();
  }

  ArrangerConstraints _makeArrangerConstraints() {
    return new ArrangerConstraints(
      areaWidth: area.size.width,
      areaHeight: area.size.height,
      positionTopOf: area.minuteOfDayFromAreaTop,
      heightOf: area.heightOfDuration,
    );
  }

  ItemPosition _makeItemPosition(ArrangedEvent arrangedEvent) {
    return new ItemPosition(
      top: arrangedEvent.top + area.top,
      left: arrangedEvent.left + area.left,
    );
  }

  ItemSize _makeItemSize(ArrangedEvent arrangedEvent) {
    return new ItemSize(
      width: arrangedEvent.width,
      height: arrangedEvent.height,
    );
  }
}

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
    @required this.restrictions,
    @required this.filter,
    @required this.arranger,
    @required this.positioningAssistant,
    @required this.builder,
    @required this.date,
    @required this.dayNumber,
  })  : assert(context != null),
        assert(arranger != null),
        assert(positioningAssistant != null),
        assert(builder != null),
        assert(date != null),
        assert(dayNumber != null && dayNumber >= 0);

  final BuildContext context;

  final Restrictions restrictions;
  final EventsFilter filter;
  final EventsArranger arranger;
  final PositioningAssistant positioningAssistant;
  final EventBuilder builder;

  final DateTime date;
  final int dayNumber;

  List<Positioned> createItems() {
    Set<PositionableEvent> events = _getEvents();
    List<ArrangedEvent> arrangedEvents = _arrangeEvents(events);
    return _buildArrangedEvents(arrangedEvents);
  }

  Set<PositionableEvent> _getEvents() {
    SingleDayEventsPreparer eventsPreparer = new SingleDayEventsPreparer(
      context: context,
      restrictions: restrictions,
      filter: filter,
      date: date,
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
      areaWidth: positioningAssistant.dayAreaWidth(dayNumber),
      areaHeight: positioningAssistant.dayAreaHeight(dayNumber),
      positionTopOf: (int minuteOfDay) {
        return positioningAssistant.minuteOfDayFromTopInsideDayArea(
          dayNumber,
          minuteOfDay,
        );
      },
      heightOf: positioningAssistant.heightOfMinutes,
    );
  }

  ItemPosition _makeItemPosition(ArrangedEvent arrangedEvent) {
    return new ItemPosition(
      top: arrangedEvent.top + positioningAssistant.dayAreaTop(dayNumber),
      left: arrangedEvent.left + positioningAssistant.dayAreaLeft(dayNumber),
    );
  }

  ItemSize _makeItemSize(ArrangedEvent arrangedEvent) {
    return new ItemSize(
      width: arrangedEvent.width,
      height: arrangedEvent.height,
    );
  }
}

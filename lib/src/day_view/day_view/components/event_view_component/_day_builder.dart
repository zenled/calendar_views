import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/event.dart';

@immutable
class DayBuilder {
  DayBuilder({
    @required this.context,
    @required this.events,
    @required this.area,
    @required this.eventsArranger,
    @required this.eventItemBuilder,
  })  : assert(context != null),
        assert(events != null),
        assert(area != null),
        assert(eventsArranger != null),
        assert(eventItemBuilder != null);

  final BuildContext context;

  final List<TimePositionableEvent> events;
  final Area area;
  final EventsArranger eventsArranger;
  final EventItemBuilder eventItemBuilder;

  List<Positioned> build() {
    List<ArrangedEvent> arrangedEvents = _arrangeEvents();
    return _buildArrangedEvents(arrangedEvents);
  }

  List<ArrangedEvent> _arrangeEvents() {
    return eventsArranger.arrangeEvents(
      events: events,
      constraints: _makeArrangerConstraints(),
    );
  }

  ArrangerConstraints _makeArrangerConstraints() {
    return new ArrangerConstraints(
      areaWidth: area.size.width,
      areaHeight: area.size.height,
      positionOfMinuteFromTop: area.minuteOfDayFromTop,
      heightOfDuration: area.heightOfDuration,
    );
  }

  List<Positioned> _buildArrangedEvents(List<ArrangedEvent> arrangedEvents) {
    return arrangedEvents
        .map(
          _buildArrangedEvent,
        )
        .toList();
  }

  Positioned _buildArrangedEvent(ArrangedEvent arrangedEvent) {
    return eventItemBuilder(
      context: context,
      position: _createItemPosition(arrangedEvent),
      size: _createItemSize(arrangedEvent),
      event: arrangedEvent.event,
    );
  }

  ItemPosition _createItemPosition(ArrangedEvent arrangedEvent) {
    return new ItemPosition(
      top: arrangedEvent.top,
      left: arrangedEvent.left,
    );
  }

  ItemSize _createItemSize(ArrangedEvent arrangedEvent) {
    return new ItemSize(
      width: arrangedEvent.width,
      height: arrangedEvent.height,
    );
  }
}

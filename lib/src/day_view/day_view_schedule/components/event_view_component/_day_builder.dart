import 'package:calendar_views/day_view.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Class that builds events of a day displayed by [EventViewComponent].
@immutable
class DayBuilder {
  DayBuilder({
    required this.context,
    required this.dayNumber,
    required this.events,
    required this.eventArranger,
    required this.positioner,
  });

  final BuildContext context;

  final int dayNumber;
  final Iterable<StartDurationItem> events;
  final EventViewArranger eventArranger;

  final SchedulePositioner positioner;

  List<Positioned> build() {
    List<ArrangedEvent> arrangedEvents = _arrangeEvents();
    return _buildArrangedEvents(arrangedEvents);
  }

  List<ArrangedEvent> _arrangeEvents() {
    return eventArranger.arrangeEvents(
      events,
      _makeArrangerConstraints(),
    );
  }

  ArrangerConstraints _makeArrangerConstraints() {
    return ArrangerConstraints(
      areaWidth: positioner.dayAreaWidth(dayNumber),
      areaHeight: positioner.totalHeight,
      minuteOfDayFromTop: positioner.minuteOfDayFromTop,
      heightOfDuration: positioner.heightOfDuration,
    );
  }

  List<Positioned> _buildArrangedEvents(List<ArrangedEvent> arrangedEvents) {
    return arrangedEvents.map(_buildArrangedEvent).toList();
  }

  Positioned _buildArrangedEvent(ArrangedEvent arrangedEvent) {
    return arrangedEvent.event.builder(
      context,
      _makeItemPosition(arrangedEvent),
      _makeItemSize(arrangedEvent),
    );
  }

  ItemPosition _makeItemPosition(ArrangedEvent arrangedEvent) {
    return ItemPosition(
      top: arrangedEvent.top,
      left: positioner.dayAreaLeft(dayNumber) + arrangedEvent.left,
    );
  }

  ItemSize _makeItemSize(ArrangedEvent arrangedEvent) {
    return ItemSize(
      width: arrangedEvent.width,
      height: arrangedEvent.height,
    );
  }
}

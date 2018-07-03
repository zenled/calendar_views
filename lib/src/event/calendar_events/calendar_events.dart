library calendar_events;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/events_manager/events_manager.dart';
import 'package:calendar_views/src/event/events/positionable_event.dart';

part 'events_changed_notifier.dart';

part 'events_provider.dart';

part 'events_refresher.dart';

class CalendarEvents extends StatefulWidget {
  CalendarEvents({
    @required this.eventsFetcher,
    @required this.child,
  })  : assert(eventsFetcher != null),
        assert(child != null);

  final Widget child;

  /// Function that provides events to this widget.
  final EventsFetcher eventsFetcher;

  @override
  _CalendarEventsState createState() => new _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  EventsManager _eventsManager;

  @override
  void initState() {
    super.initState();

    _eventsManager = new EventsManager(
      eventsFetcher: widget.eventsFetcher,
    );
  }

  @override
  void didUpdateWidget(CalendarEvents oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.eventsFetcher != widget.eventsFetcher) {
      _eventsManager.updateEventsFetcher(widget.eventsFetcher);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new EventsProvider(
      getEventsOf: _eventsManager.getEventsOf,
      child: new EventsRefresher(
        refreshEventsOf: _eventsManager.refreshEventsOf,
        refreshEventsOfAllDates: _eventsManager.refreshEventsOfAllDates,
        child: new EventsChangedNotifier(
          attach: _eventsManager.attachEventsChangedListener,
          detach: _eventsManager.detachEventsChangedListener,
          child: widget.child,
        ),
      ),
    );
  }
}

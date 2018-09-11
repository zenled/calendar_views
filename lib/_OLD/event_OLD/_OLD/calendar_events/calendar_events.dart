import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/event/_events_manager/events_manager.dart';

import 'events_changed_notifier.dart';
import 'events_provider.dart';
import 'events_generator.dart';
import 'events_refresher.dart';

/// Widget that manages events.
///
/// This widget should preferably be set near the start of the widget tree.
///
/// Following widgets are automatically created as children of this widget:
/// * [EventsChangedNotifier]
/// * [EventsProvider]
/// * [EventsRefresher]
class CalendarEvents extends StatefulWidget {
  CalendarEvents({
    @required this.eventsRetriever,
    @required this.child,
  })  : assert(eventsRetriever != null),
        assert(child != null);

  ///
  final EventsGenerator eventsRetriever;

  final Widget child;

  @override
  _CalendarEventsState createState() => new _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  EventsManager _eventsManager;

  @override
  void initState() {
    super.initState();

    _eventsManager = new EventsManager(
      eventsRetriever: widget.eventsRetriever,
    );
  }

  @override
  void didUpdateWidget(CalendarEvents oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.eventsRetriever != oldWidget.eventsRetriever) {
      _eventsManager.changeEventsRetriever(widget.eventsRetriever);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new EventsChangedNotifier(
      attach: _eventsManager.attachEventsChangedListener,
      detach: _eventsManager.detachEventsChangedListener,
      child: new EventsProvider(
        getEventsOf: _eventsManager.getEventsOf,
        child: new EventsRefresher(
          refreshEventsOf: _eventsManager.refreshEventsOf,
          refreshAllEvents: _eventsManager.refreshAllEvents,
          child: widget.child,
        ),
      ),
    );
  }
}

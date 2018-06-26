import 'package:flutter/material.dart';

import '../positionable_event.dart';

import 'events_master.dart';

/// Function that returns a set of events that happen on specific [date].
typedef Set<PositionableEvent> EventsGetter(DateTime date);

typedef RefreshEventsOfDateCallback(DateTime date);

class CalendarEvents extends StatefulWidget {
  CalendarEvents({
    @required this.eventsFetcher,
    @required this.child,
  })  : assert(eventsFetcher != null),
        assert(child != null);

  final Widget child;

  final EventsFetcher eventsFetcher;

  @override
  _CalendarEventsState createState() => new _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  EventsMaster _eventsMaster;

  @override
  void initState() {
    super.initState();

    _eventsMaster = new EventsMaster(
      eventsFetcher: widget.eventsFetcher,
    );
  }

  @override
  void didUpdateWidget(CalendarEvents oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.eventsFetcher != widget.eventsFetcher) {
      _eventsMaster.eventsFetcher = widget.eventsFetcher;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new EventsProvider(
      getEventsOfDate: _eventsMaster.getEventsOfDate,
      attachOnEventsOfDateChangedListener: _eventsMaster.attachListener,
      detachOnEventsOfDateChangedListener: _eventsMaster.detachListener,
      refreshEventsOfDate: _eventsMaster.refreshEventsOfDate,
      refreshEventsOfAllDates: _eventsMaster.refreshEventsOfAllDates,
      child: widget.child,
    );
  }
}

class EventsProvider extends InheritedWidget {
  EventsProvider({
    @required this.getEventsOfDate,
    @required this.attachOnEventsOfDateChangedListener,
    @required this.detachOnEventsOfDateChangedListener,
    @required this.refreshEventsOfDate,
    @required this.refreshEventsOfAllDates,
    @required Widget child,
  })  : assert(getEventsOfDate != null),
        assert(attachOnEventsOfDateChangedListener != null),
        assert(detachOnEventsOfDateChangedListener != null),
        assert(refreshEventsOfDate != null),
        assert(refreshEventsOfAllDates != null),
        super(child: child);

  /// Returns a set of events that happen on [date].
  final EventsGetter getEventsOfDate;

  /// Attaches [EventsOfDateChangedListener].
  final EventsOfDateChangedListenerCallback attachOnEventsOfDateChangedListener;

  /// Detaches [EventsOfDateChangedListener].
  final EventsOfDateChangedListenerCallback detachOnEventsOfDateChangedListener;

  /// Forces a refresh of evens that happen on [date]
  final RefreshEventsOfDateCallback refreshEventsOfDate;

  /// Forces a refresh of events of all dates of which data has been previously fetched.
  final VoidCallback refreshEventsOfAllDates;

  @override
  bool updateShouldNotify(EventsProvider oldWidget) {
    return oldWidget.getEventsOfDate != getEventsOfDate ||
        oldWidget.attachOnEventsOfDateChangedListener !=
            attachOnEventsOfDateChangedListener ||
        oldWidget.detachOnEventsOfDateChangedListener !=
            detachOnEventsOfDateChangedListener ||
        oldWidget.refreshEventsOfDate != refreshEventsOfDate ||
        oldWidget.refreshEventsOfAllDates != refreshEventsOfDate;
  }

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}

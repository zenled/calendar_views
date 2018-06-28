import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positions/positions.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import 'components/components.dart';

import 'day_view_dates.dart';
import 'day_view_width.dart';

class DayView extends StatefulWidget {
  const DayView({
    @required this.dates,
  }) : assert(dates != null);

  factory DayView.forSingleDay({
    @required DateTime day,
  }) {
    assert(day != null);

    return new DayView(
      dates: <DateTime>[day],
    );
  }

  /// Dates of which events are displayed by this DayView.
  final List<DateTime> dates;

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {
  bool _areEventsChangedListenerAttached;
  List<EventsChangedListener> _eventsChangedListeners;

  @override
  void initState() {
    super.initState();

    _areEventsChangedListenerAttached = false;
    _eventsChangedListeners = _createEventsChangedListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _detachEventsChangedListeners();
  }

  @override
  void didUpdateWidget(DayView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!utils.areListsOfDatesTheSame(oldWidget.dates, widget.dates)) {
      _detachEventsChangedListeners();
      _eventsChangedListeners = _createEventsChangedListeners();
      _areEventsChangedListenerAttached = false;
    }
  }

  List<EventsChangedListener> _createEventsChangedListeners() {
    return widget.dates
        .map(
          (date) => new EventsChangedListener(
              date: date,
              onEventsChanged: () {
                setState(() {});
              }),
        )
        .toList();
  }

  void _attachEventsChangedListeners() {
    EventsChangedNotifier changedNotifier = EventsChangedNotifier.of(context);

    for (EventsChangedListener listener in _eventsChangedListeners) {
      changedNotifier.attach(listener);
    }
  }

  void _detachEventsChangedListeners() {
    EventsChangedNotifier changedNotifier = EventsChangedNotifier.of(context);

    for (EventsChangedListener listener in _eventsChangedListeners) {
      changedNotifier.detach(listener);
    }
  }

  double _determineWidgetHeight(BuildContext context) {
    return DayViewPositionerGenerator
        .of(context)
        .createPositioner(context)
        .height;
  }

  @override
  Widget build(BuildContext context) {
    if (!_areEventsChangedListenerAttached) {
      _attachEventsChangedListeners();
      _areEventsChangedListenerAttached = true;
    }

    return new DayViewDates(
      dates: widget.dates,
      child: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return new DayViewWidth(
            width: constraints.maxWidth,
            child: new Builder(builder: (BuildContext context) {
              // Builder is required so that we can determine height and width.
              return new Container(
                width: DayViewWidth.of(context).width,
                height: _determineWidgetHeight(context),
                child: new Stack(
                  children: _buildComponents(context),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  List<Positioned> _buildComponents(BuildContext context) {
    // Context needs to be passed here so that components can access inherited widgets created in the build method.

    List<Positioned> builtComponents = <Positioned>[];

    List<DayViewComponent> components =
        DayViewComponentsProvider.of(context).components;
    for (DayViewComponent component in components) {
      builtComponents.addAll(
        component.buildItems(context),
      );
    }

    return builtComponents;
  }
}

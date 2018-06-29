import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import 'components/all.dart';
import 'positioning_assistant/all.dart';
import 'properties/all.dart';

class DayView extends StatefulWidget {
  const DayView({
    @required this.dates,
  }) : assert(dates != null);

  factory DayView.fromAListOfDates({
    @required List<DateTime> dates,
  }) {
    assert(dates != null);

    return new DayView(
      dates: new Days(dates: dates),
    );
  }

  factory DayView.forASingleDay({
    @required DateTime day,
  }) {
    assert(day != null);

    return new DayView(
      dates: new Days(
        dates: <DateTime>[day],
      ),
    );
  }

  /// Dates of which events are displayed by this DayView.
  final Days dates;

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {
  bool _areEventsChangedListenersAttached;
  List<EventsChangedListener> _eventsChangedListeners;

  @override
  void initState() {
    super.initState();

    _areEventsChangedListenersAttached = false;
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

    if (!utils.areListsOfDatesTheSame(
      widget.dates.dates,
      oldWidget.dates.dates,
    )) {
      _detachEventsChangedListeners();
      _eventsChangedListeners = _createEventsChangedListeners();
      _areEventsChangedListenersAttached = false;
    }
  }

  List<EventsChangedListener> _createEventsChangedListeners() {
    return widget.dates.dates
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

  @override
  Widget build(BuildContext context) {
    if (!_areEventsChangedListenersAttached) {
      _attachEventsChangedListeners();
      _areEventsChangedListenersAttached = true;
    }

    return new DaysProvider(
      dates: widget.dates,
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return new SizesProvider(
          sizes: new Sizes(totalAvailableWidth: constraints.maxWidth),
          child: new Builder(builder: (BuildContext context) {
            // A Builder is needed here so PositioningAssistantGenerator can access sizes

            PositioningAssistant positioningAssistant =
                _createPositioningAssistant(context);

            return new PositioningAssistantProvider(
              positioningAssistant: positioningAssistant,
              child: new Builder(builder: (BuildContext context) {
                // A Builder is needed so Components can access PositioningAssistantProvider

                return new Container(
                  width: positioningAssistant.totalAreaWidth,
                  height: positioningAssistant.totalAreaHeight,
                  child: new Stack(
                    children: _buildComponentItems(context),
                  ),
                );
              }),
            );
          }),
        );
      }),
    );
  }

  List<Positioned> _buildComponentItems(BuildContext context) {
    List<Positioned> builtComponentsItems = <Positioned>[];

    for (Component component in _getComponents(context)) {
      builtComponentsItems.addAll(
        component.buildItems(context),
      );
    }

    return builtComponentsItems;
  }

  PositioningAssistant _createPositioningAssistant(BuildContext context) {
    return PositioningAssistantGenerator
        .of(context)
        .generatePositioningAssistant(context);
  }

  List<Component> _getComponents(BuildContext context) {
    return ComponentsProvider.of(context);
  }
}

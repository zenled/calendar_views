import 'package:flutter/material.dart';

import 'package:calendar_views/event.dart';

import 'components/all.dart';
import 'positioning_assistant/all.dart';
import 'properties/all.dart';

class DayView extends StatefulWidget {
  const DayView();

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
  }

  @override
  void dispose() {
    super.dispose();

    _detachEventsChangedListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _detachEventsChangedListeners();

    _areEventsChangedListenersAttached = false;
  }

  void _createAndAttachEventsChangedListeners() {
    Days days = _getDays();

    _eventsChangedListeners = _createEventsChangedListeners(days);

    _attachEventsChangedListeners();

    _areEventsChangedListenersAttached = true;
  }

  List<EventsChangedListener> _createEventsChangedListeners(Days days) {
    return days.dates
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
    EventsChangedNotifier changedNotifier = _getEventsChangedNotifier();

    for (EventsChangedListener listener in _eventsChangedListeners) {
      changedNotifier.attach(listener);
    }
  }

  void _detachEventsChangedListeners() {
    EventsChangedNotifier changedNotifier = _getEventsChangedNotifier();

    for (EventsChangedListener listener in _eventsChangedListeners) {
      changedNotifier.detach(listener);
    }
  }

  Days _getDays() {
    return DaysProvider.of(context);
  }

  EventsChangedNotifier _getEventsChangedNotifier() {
    return EventsChangedNotifier.of(context);
  }

  PositioningAssistant _getPositioningAssistant() {
    return PositioningAssistantProvider.of(context);
  }

  List<Component> _getComponents() {
    return ComponentsProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_areEventsChangedListenersAttached) {
      _createAndAttachEventsChangedListeners();
    }

    PositioningAssistant positioningAssistant = _getPositioningAssistant();

    return new Container(
      width: positioningAssistant.totalAreaWidth,
      height: positioningAssistant.totalAreaHeight,
      child: new Stack(
        children: _buildComponentItems(),
      ),
    );
  }

  List<Positioned> _buildComponentItems() {
    List<Positioned> builtComponentsItems = <Positioned>[];

    for (Component component in _getComponents()) {
      builtComponentsItems.addAll(
        component.buildItems(context),
      );
    }

    return builtComponentsItems;
  }
}

import 'package:flutter/material.dart';

import 'package:calendar_views/event.dart';

import 'components_OLD/all.dart';
import 'positioning_assistant/all.dart';
import 'properties/all.dart';

/// Widget that displays a day view.
class DayViewOLD extends StatefulWidget {
  const DayViewOLD({
    this.rebuildWhenEventsChange = true,
  }) : assert(rebuildWhenEventsChange != null);

  /// If true components will be rebuilt when events of days inside this dayView change.
  ///
  /// If true this [DayViewOLD] will attach to [EventsChangedNotifier]
  /// and rebuild all components when notified.
  final bool rebuildWhenEventsChange;

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayViewOLD> {
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
  void didUpdateWidget(DayViewOLD oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.rebuildWhenEventsChange) {
      _detachEventsChangedListeners();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _detachEventsChangedListeners();
  }

  void _createAndAttachEventsChangedListeners() {
    DaysData days = _getDaysData();

    _eventsChangedListeners = _createEventsChangedListeners(days);

    _attachEventsChangedListeners();
  }

  List<EventsChangedListener> _createEventsChangedListeners(DaysData daysData) {
    return daysData.days
        .map(
          (day) => new EventsChangedListener(
                day: day,
                onEventsChanged: () {
                  setState(() {});
                },
              ),
        )
        .toList();
  }

  void _attachEventsChangedListeners() {
    EventsChangedNotifier changedNotifier = _getEventsChangedNotifier();

    for (EventsChangedListener listener in _eventsChangedListeners) {
      changedNotifier.attach(listener);
    }

    _areEventsChangedListenersAttached = true;
  }

  void _detachEventsChangedListeners() {
    if (_areEventsChangedListenersAttached) {
      EventsChangedNotifier changedNotifier = _getEventsChangedNotifier();

      for (EventsChangedListener listener in _eventsChangedListeners) {
        changedNotifier.detach(listener);
      }

      _areEventsChangedListenersAttached = false;
    }
  }

  DaysData _getDaysData() {
    return DaysOLD.of(context);
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
    if (!_areEventsChangedListenersAttached && widget.rebuildWhenEventsChange) {
      _createAndAttachEventsChangedListeners();
    }

    PositioningAssistant positioningAssistant = _getPositioningAssistant();

    return new Container(
      width: positioningAssistant.nonPaddedAreaWidth,
      height: positioningAssistant.nonPaddedAreaHeight,
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

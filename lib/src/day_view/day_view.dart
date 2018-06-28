import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/day_view/positions/positions.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import 'components/components.dart';

import 'day_view_date.dart';
import 'day_view_width.dart';

class DayView extends StatefulWidget {
  const DayView({
    @required this.date,
  }) : assert(date != null);

  /// Date which events are displayed by this day view.
  final DateTime date;

  @override
  _DayViewState createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {
  bool _isEventsChangedListenerAttached;
  EventsChangedListener _eventsChangedListener;

  @override
  void initState() {
    super.initState();

    _isEventsChangedListenerAttached = false;
    _eventsChangedListener = _initEventsChangedListener();
  }

  @override
  void dispose() {
    super.dispose();

    _detachEventsChangedListener();
  }

  @override
  void didUpdateWidget(DayView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!utils.isSameDate(oldWidget.date, widget.date)) {
      _detachEventsChangedListener();
      _eventsChangedListener = _initEventsChangedListener();
      _attachEventsChangedListener();
    }
  }

  EventsChangedListener _initEventsChangedListener() {
    return new EventsChangedListener(
      date: widget.date,
      onEventsChanged: () {
        setState(() {});
      },
    );
  }

  void _attachEventsChangedListener() {
    EventsChangedNotifier.of(context).attach(_eventsChangedListener);
  }

  void _detachEventsChangedListener() {
    EventsChangedNotifier.of(context).detach(_eventsChangedListener);
  }

  double _determineWidgetHeight(BuildContext context) {
    return DayViewPositionerGenerator
        .of(context)
        .createPositioner(context)
        .height;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEventsChangedListenerAttached) {
      _attachEventsChangedListener();
      _isEventsChangedListenerAttached = true;
    }

    return new DayViewDate(
      date: widget.date,
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

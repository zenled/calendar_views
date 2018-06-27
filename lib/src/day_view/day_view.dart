import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/src/utils/all.dart' as utils;

import 'dimensions_positions/all.dart';
import 'components/all.dart';
import 'day_view_date.dart';

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
  bool _isOnEventsChangedListenerAttached;
  OnEventsChangedListener _onEventsChangedListener;

  @override
  void initState() {
    super.initState();

    _isOnEventsChangedListenerAttached = false;
    _onEventsChangedListener = _initOnEventsChangedListener();
  }

  @override
  void dispose() {
    super.dispose();

    _detachOnEventsChangedListener();
  }

  @override
  void didUpdateWidget(DayView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!utils.isSameDate(oldWidget.date, widget.date)) {
      _detachOnEventsChangedListener();
      _onEventsChangedListener = _initOnEventsChangedListener();
      _attachOnEventsChangedListener();
    }
  }

  OnEventsChangedListener _initOnEventsChangedListener() {
    return new OnEventsChangedListener(
      date: widget.date,
      onEventsChanged: () {
        setState(() {});
      },
    );
  }

  void _attachOnEventsChangedListener() {
    EventsChangedNotifier.of(context).attach(_onEventsChangedListener);
  }

  void _detachOnEventsChangedListener() {
    EventsChangedNotifier.of(context).detach(_onEventsChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnEventsChangedListenerAttached) {
      _attachOnEventsChangedListener();
      _isOnEventsChangedListenerAttached = true;
    }

    return new Container(
      width: DayViewPositions.of(context).width,
      height: DayViewPositions.of(context).height,
      child: new DayViewDate(
        date: widget.date,
        child:
            // A builder is required so that components can access DayViewDate
            new Builder(builder: (BuildContext context) {
          return new Stack(
            children: _buildComponents(context),
          );
        }),
      ),
    );
  }

  List<Positioned> _buildComponents(BuildContext context) {
    /// Context needs to be passed here so components can access [DayViewDate].

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

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'day_of_month_builder.dart';
import 'day_of_month_properties.dart';

import 'package:calendar_views/event.dart';

class MonthViewDay extends StatefulWidget {
  MonthViewDay({
    @required this.properties,
    @required this.rebuildWhenEventsChange,
    @required this.builder,
    Key key,
  })  : assert(properties != null),
        assert(rebuildWhenEventsChange != null),
        assert(builder != null),
        super(key: key);

  final DayOfMonthProperties properties;

  final bool rebuildWhenEventsChange;

  final DayOfMonthBuilder builder;

  @override
  _MonthViewDayState createState() => new _MonthViewDayState();
}

class _MonthViewDayState extends State<MonthViewDay> {
  EventsChangedListener _eventsChangedListener;

  @override
  void initState() {
    super.initState();

    _eventsChangedListener = _createEventsChangedListener();
    if (widget.rebuildWhenEventsChange) {
      _attachEventsChangedListener();
    }
  }

  @override
  void dispose() {
    if (widget.rebuildWhenEventsChange) {
      _detachEventsChangedListener();
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(MonthViewDay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.rebuildWhenEventsChange != oldWidget.rebuildWhenEventsChange) {
      if (widget.rebuildWhenEventsChange) {
        _attachEventsChangedListener();
      } else {
        _detachEventsChangedListener();
      }
    }
  }

  EventsChangedListener _createEventsChangedListener() {
    return new EventsChangedListener(
      day: widget.properties.date,
      onEventsChanged: () {
        setState(() {});
      },
    );
  }

  void _attachEventsChangedListener() {
    EventsChangedNotifier.of(context).attach(
          _eventsChangedListener,
        );
  }

  void _detachEventsChangedListener() {
    EventsChangedNotifier.of(context).detach(
          _eventsChangedListener,
        );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.properties);
  }
}

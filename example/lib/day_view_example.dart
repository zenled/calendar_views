import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayViewExample extends StatefulWidget {
  @override
  State createState() => new _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DayView Example"),
      ),
      body: new DayViewSubtree(
        properties: new Properties(
          days: <DateTime>[
            new DateTime.now(),
            new DateTime.now(),
            new DateTime.now(),
          ],
        ),
        widths: new Widths(paddingStart: 8.0),
        child: new Column(
          children: <Widget>[
            new DayViewHeader(
              headerItemBuilder: (context, day) {
                return new Container(
                  color: Colors.red,
                  constraints: new BoxConstraints.expand(
                    height: 20.0,
                  ),
                );
              },
            ),
            new Expanded(
                child: new SingleChildScrollView(
              child: new DayView(
                heightPerMinute: 0.5,
                components: <DayViewComponent>[
                  new TimeIndicationComponent(
                    timeIndicators: _makeTimeIndicationItems(),
                    timeIndicatorItemBuilder: _timeIndicationBuilder,
                  ),
                  new EventViewComponent(
                    getEventsOfDay: _getEventsOfDay,
                    eventItemBuilder: _eventItemBuilder,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  List<ItemWithStartDuration> _makeTimeIndicationItems() {
    List<ItemWithStartDuration> items = <ItemWithStartDuration>[];

    for (int start = 0; start < 24 * 60; start += 60) {
      items.add(
        new TimeIndicator(
          title: "${start ~/ 60}:${start % 60}",
          startMinuteOfDay: start - 30,
          duration: 60,
        ),
      );
    }

    return items;
  }

  Positioned _timeIndicationBuilder({
    @required BuildContext context,
    @required ItemPosition position,
    @required ItemSize size,
    @required ItemWithStartDuration item,
  }) {
    TimeIndicator timeIndicator = item as TimeIndicator;

    return new Positioned(
      left: position.left,
      top: position.top,
      width: size.width,
      height: size.height,
      child: new Container(
        color: Colors.orange,
        constraints: new BoxConstraints.expand(),
        child: new Center(
          child: new Text(
            "${timeIndicator.title}",
          ),
        ),
      ),
    );
  }

  Set<ItemWithStartDuration> _getEventsOfDay(DateTime day) {
    return <ItemWithStartDuration>[
      new Event(title: "A", startMinuteOfDay: 0, duration: 60),
      new Event(title: "B", startMinuteOfDay: 0, duration: 30),
      new Event(title: "C", startMinuteOfDay: 45, duration: 60),
      new Event(title: "D", startMinuteOfDay: 4 * 60, duration: 60),
      new Event(title: "E", startMinuteOfDay: 5 * 60, duration: 90),
      new Event(title: "F", startMinuteOfDay: 5 * 60, duration: 60),
      new Event(title: "G", startMinuteOfDay: (5 * 60) + 15, duration: 60),
    ].toSet();
  }

  Positioned _eventItemBuilder({
    @required BuildContext context,
    @required ItemPosition position,
    @required ItemSize size,
    @required ItemWithStartDuration item,
  }) {
    Event event = item as Event;

    return new Positioned(
        top: position.top,
        left: position.left,
        width: size.width,
        height: size.height,
        child: new Container(
          color: Colors.blue[200],
          child: new Center(
            child: new Text(event.title),
          ),
        ));
  }
}

class TimeIndicator extends ItemWithStartDuration {
  TimeIndicator({
    @required this.title,
    @required this.startMinuteOfDay,
    @required this.duration,
  });

  final String title;

  @override
  final int startMinuteOfDay;

  @override
  final int duration;
}

class Event implements ItemWithStartDuration {
  Event({
    @required this.title,
    @required this.startMinuteOfDay,
    @required this.duration,
  });

  final String title;

  @override
  final int startMinuteOfDay;

  @override
  final int duration;
}

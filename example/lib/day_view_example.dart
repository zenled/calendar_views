import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayViewExample extends StatefulWidget {
  @override
  _DayViewExampleState createState() => new _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DayView Example"),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new EventsProvider(
          events: <PositionableEvent>[
            new SimpleEvent(
                beginMinuteOfDay: 5 * 60, duration: 60, title: "Before"),
            new SimpleEvent(
                beginMinuteOfDay: 11 * 60, duration: 60, title: "Abc"),
          ].toSet(),
          child: new DayViewProperties(
            minimumMinuteOfDay: 7 * 60,
            width: MediaQuery.of(context).size.width,
            dimensions: new DayViewDimensions(),
            items: <DayViewComponent>[
              new IntervalTimeIndicatorsComponent.everyHour(),
              new IntervalSupportLineComponent.everyHour(),
              new SingleDayEventsComponent(itemBuilder: eventWithTitleBuilder),
            ],
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new DayView(
                    date: new DateTime.now(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

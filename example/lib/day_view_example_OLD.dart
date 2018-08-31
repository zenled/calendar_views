import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import 'dummy_evets_generator.dart';

class DayViewExample extends StatefulWidget {
  @override
  _DayViewExampleState createState() => new _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  DummyEventsGenerator _dummyEventsGenerator;

  @override
  void initState() {
    super.initState();

    _dummyEventsGenerator = new DummyEventsGenerator();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DayView Example"),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new CalendarEvents(
          eventsRetriever: _dummyEventsGenerator,
          child: new Builder(
            builder: (BuildContext context) {
              return new CalendarEvents(
                eventsRetriever: _dummyEventsGenerator,
                child: new DayViewResources(
                  restrictions: new RestrictionsData(
                    minimumMinuteOfDay: 6 * 60,
                    maximumMinuteOfDay: 21 * 60,
                  ),
                  dimensions: new DimensionsData(),
                  components: <Component>[
                    new IntervalTimeIndicationComponent.everyHour(),
                    new IntervalSupportLineComponent.everyHour(),
                    new DaySeparationComponent(),
                    new EventViewComponent(eventItemBuilder: eventWithTitleBuilder),
                  ],
                  child: new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 16.0),
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new DayViewInstance.fromListOfDays(
                            days: <DateTime>[
                              new DateTime.now(),
                              new DateTime.now().add(new Duration(days: 1)),
                            ],
                            child: new Column(
                              children: <Widget>[
                                new DaysHeader.builder(
                                  extendOverDaySeparation: false,
                                  extendOverEventsAreaStartMargin: false,
                                  extendOverEventsAreaEndMargin: false,
                                  eventItemBuilder: _headerItemBuilder,
                                ),
                                new Expanded(
                                  child: new SingleChildScrollView(
                                    child: new DayView(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _headerItemBuilder(BuildContext context, DateTime date) {
    return new Container(
      height: 40.0,
      color: Colors.redAccent,
      child: new Center(
        child: new Text(
          "${date.month.toString().padLeft(2, "0")}."
              "${date.day.toString().padLeft(2, "0")}",
        ),
      ),
    );
  }
}

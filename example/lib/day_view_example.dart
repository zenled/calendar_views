import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import 'dummy_evets_fetcher.dart';

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
        return new CalendarEvents(
          eventsFetcher: dummyEventsFetcher,
          child: new Builder(
            builder: (BuildContext context) {
              return new DayViewResources(
                dimensions: new Dimensions(),
                components: <Component>[
                  new IntervalTimeIndicationComponent.everyHour(),
                  new IntervalSupportLineComponent.everyHour(),
                  new DaySeparationComponent(),
                  new EventViewComponent(eventBuilder: eventWithTitleBuilder),
                ],
                child: new SingleChildScrollView(
                  child: new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 16.0),
                    child: new DayViewInstance(
                      days: new Days(dates: <DateTime>[
                        new DateTime.now(),
                        new DateTime.now().add(new Duration(days: 1)),
                        new DateTime.now().add(new Duration(days: 1)),
                        new DateTime.now(),
                        new DateTime.now(),
                        new DateTime.now(),
                        new DateTime.now(),
                      ]),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 20.0,
                          ),
                          new RaisedButton(
                              child: new Text("Refresh events"),
                              onPressed: () {
                                EventsRefresher
                                    .of(context)
                                    .refreshEventsOfAllDates();
                              }),
                          new Container(
                            height: 20.0,
                          ),
                          new DaysHeader.builder(
                            headerBuilder: _headerBuilder,
                          ),
                          new Container(
                            height: 20.0,
                          ),
                          new DayView(),
                        ],
                      ),
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

  Widget _headerBuilder({
    @required BuildContext context,
    @required DateTime date,
  }) {
    return new Container(
      height: 20.0,
      color: Colors.redAccent,
      child: new Center(
        child: new Text("${date.month}.${date.day}"),
      ),
    );
  }
}

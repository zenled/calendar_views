import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import 'utils/all.dart';

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
      body: new DayViewEssentials(
        properties: new DayViewProperties(
          days: <DateTime>[
            new DateTime.now(),
            new DateTime.now().add(new Duration(days: 1)),
          ],
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              color: Colors.grey[200],
              child: new DayViewDaysHeader(
                headerItemBuilder: _headerItemBuilder,
              ),
            ),
            new Expanded(
              child: new Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerItemBuilder(BuildContext context, DateTime day) {
    return new Container(
      color: Colors.grey[300],
      child: new Column(
        children: <Widget>[
          new Text(
            "${weekdayToAbbreviatedString(day.weekday)}",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text("${day.day}"),
        ],
      ),
    );
  }
}

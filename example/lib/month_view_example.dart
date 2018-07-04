import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/month_view.dart';

class MonthViewExample extends StatefulWidget {
  @override
  _MonthViewExampleState createState() => new _MonthViewExampleState();
}

class _MonthViewExampleState extends State<MonthViewExample> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MonthView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new MonthView(
              month: new DateTime.now(),
              dayOfMonthBuilder: _dayOfMonthBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayOfMonthBuilder(
      BuildContext context, DayOfMonthProperties properties) {
    return new Center(
      child: new Text(
        "${properties.date.day}",
        style: new TextStyle(
            fontWeight:
                properties.isExtended ? FontWeight.normal : FontWeight.bold),
      ),
    );
  }
}

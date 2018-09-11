import 'package:flutter/material.dart';

import 'days_page_view.dart';
import 'day_view_example.dart';
import 'month_example.dart';
import 'month_page_view_example.dart';
import 'month_view_example.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "calendar_views example",
      home: new Scaffold(
        body: new Builder(builder: (BuildContext context) {
          return new SingleChildScrollView(
            child: new Container(
              padding: new EdgeInsets.only(bottom: 16.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(bottom: 16.0),
                    height: 250.0,
                    color: Colors.green.shade200,
                    child: new Center(
                      child: new Text(
                        "calendar_views \nExample",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  new Divider(
                    height: 0.0,
                  ),
                  new ListTile(
                    title: new Text("Month"),
                    subtitle: new Text("MonthPageView and MonthView"),
                    onTap: () {
                      _showWidgetInFullScreenDialog(
                        context,
                        new MonthExample(),
                      );
                    },
                  ),
                  new Container(
                    height: 10.0,
                    color: Colors.green.shade200,
                  ),
                  new ListTile(
                    title: new Text("Day View"),
                    subtitle: new Text("DayView Example"),
                    onTap: () {
                      _showWidgetInFullScreenDialog(
                        context,
                        new DayViewExample(),
                      );
                    },
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("Month View"),
                    subtitle: new Text("MonthView Example"),
                    onTap: () {
                      _showWidgetInFullScreenDialog(
                        context,
                        new MonthViewExample(),
                      );
                    },
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("Days Page View"),
                    subtitle: new Text("DaysPageView Example"),
                    onTap: () {
                      _showWidgetInFullScreenDialog(
                          context, new DaysPageViewExample());
                    },
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("MonthPageView"),
                    subtitle: new Text("MonthPageView Example"),
                    onTap: () {
                      _showWidgetInFullScreenDialog(
                        context,
                        new MonthPageViewExample(),
                      );
                    },
                  ),
                  new Divider(height: 0.0),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showWidgetInFullScreenDialog(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return widget;
        },
      ),
    );
  }
}

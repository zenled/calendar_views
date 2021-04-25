import 'package:flutter/material.dart';

import 'day_view_example.dart';
import 'days_page_view_example.dart';
import 'month_page_view_example.dart';
import 'month_view_example.dart';

void main() => runApp(MyApp());

/// Screen for picking different examples of this library.
///
/// Examples:
/// * [DayView example](day_view_example.dart)
/// * [DaysPageView example](days_page_view_example.dart)
/// * [MonthPageView example](month_page_view_example.dart)
/// * [MonthView example](month_view_example.dart)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "calendar_views example",
      home: Scaffold(
        appBar: AppBar(
          title: Text("calendar_views example"),
        ),
        body: Builder(builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text("Day View"),
                subtitle: Text("DayView Example"),
                onTap: () {
                  _showWidgetInFullScreenDialog(
                    context,
                    DayViewExample(),
                  );
                },
              ),
              Divider(height: 0.0),
              ListTile(
                title: Text("Days Page View"),
                subtitle: Text("DaysPageView Example"),
                onTap: () {
                  _showWidgetInFullScreenDialog(
                    context,
                    DaysPageViewExample(),
                  );
                },
              ),
              Divider(height: 0.0),
              ListTile(
                title: Text("Month Page View"),
                subtitle: Text("MonthPageView Example"),
                onTap: () {
                  _showWidgetInFullScreenDialog(
                    context,
                    MonthPageViewExample(),
                  );
                },
              ),
              Divider(height: 0.0),
              ListTile(
                title: Text("Month View"),
                subtitle: Text("MonthView Example"),
                onTap: () {
                  _showWidgetInFullScreenDialog(
                    context,
                    MonthViewExample(),
                  );
                },
              ),
              Divider(height: 0.0),
            ],
          );
        }),
      ),
    );
  }

  void _showWidgetInFullScreenDialog(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return widget;
        },
      ),
    );
  }
}

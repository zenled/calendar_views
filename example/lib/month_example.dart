import 'package:flutter/material.dart';

import 'package:calendar_views/month_page_view.dart';
import 'package:calendar_views/month_view.dart';

import 'weekday_drop_down_button.dart';

class MonthExample extends StatefulWidget {
  @override
  _MonthExampleState createState() => new _MonthExampleState();
}

class _MonthExampleState extends State<MonthExample> {
  String _monthString;

  MonthPageController _monthPageController;

  int _firstWeekday;

  bool _showExtendedDaysBefore;
  bool _showExtendedDaysAfter;

  @override
  void initState() {
    super.initState();

    _monthPageController = new MonthPageController(
      initialMonth: new DateTime.now(),
    );

    _firstWeekday = DateTime.monday;

    _showExtendedDaysBefore = true;
    _showExtendedDaysAfter = true;

    _monthString = _monthToString(_monthPageController.initialMonth);
  }

  String _monthToString(DateTime month) {
    return "${month.year}.${month.month.toString().padLeft(2, "0")}";
  }

  void _onMonthChanged(DateTime month) {
    setState(() {
      _monthString = _monthToString(month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Month Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            child: new Text(_monthString),
          ),
          new Divider(
            height: 0.0,
          ),
          new Expanded(
            child: new Container(
              color: Colors.green.shade200,
              child: new MonthPageView(
                controller: _monthPageController,
                onMonthChanged: _onMonthChanged,
                pageBuilder: _monthPageBuilder,
              ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: new RaisedButton(
                        child: new Text("To Today"),
                        onPressed: () {
                          _monthPageController.animateToMonth(
                            new DateTime.now(),
                            duration: new Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }),
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("First Day of Month"),
                    trailing: new WeekdayDropDownButton(
                        value: _firstWeekday,
                        onChanged: (value) {
                          setState(() {
                            _firstWeekday = value;
                          });
                        }),
                  ),
                  new Divider(),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days Before"),
                    value: _showExtendedDaysBefore,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysBefore = value;
                      });
                    },
                  ),
                  new Divider(),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days After"),
                    value: _showExtendedDaysAfter,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysAfter = value;
                      });
                    },
                  ),
                  new Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthPageBuilder(BuildContext context, DateTime month) {
    return new MonthView(
      showExtendedDaysBefore: _showExtendedDaysBefore,
      showExtendedDaysAfter: _showExtendedDaysAfter,
      month: month,
      firstWeekday: _firstWeekday,
      dayOfMonthBuilder: _dayOfMonthBuilder,
    );
  }

  Widget _dayOfMonthBuilder(
    BuildContext context,
    DayOfMonthProperties properties,
  ) {
    return new Center(
      child: new Text(
        "${properties.date.day}",
        style: new TextStyle(
          fontWeight:
              properties.isExtended ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }
}

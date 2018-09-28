import 'package:flutter/material.dart';

import 'package:calendar_views/month_view.dart';

import 'utils/all.dart';

class MonthViewExample extends StatefulWidget {
  @override
  _MonthViewExampleState createState() => new _MonthViewExampleState();
}

class _MonthViewExampleState extends State<MonthViewExample> {
  DateTime _month;
  int _firstWeekday;

  bool _shouldShowHeader;

  bool _showExtendedDaysBefore;
  bool _showExtendedDaysAfter;

  @override
  void initState() {
    super.initState();

    _month = new DateTime.now();
    _firstWeekday = DateTime.monday;

    _shouldShowHeader = true;

    _showExtendedDaysBefore = true;
    _showExtendedDaysAfter = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MonthView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.green.shade200,
              child: new MonthView(
                month: _month,
                firstWeekday: _firstWeekday,
                dayOfMonthBuilder: _dayOfMonthBuilder,
                headerItemBuilder:
                    _shouldShowHeader ? _monthViewHeaderItemBuilder : null,
                showExtendedDaysBefore: _showExtendedDaysBefore,
                showExtendedDaysAfter: _showExtendedDaysAfter,
              ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Center(
                      child: new Text("Month: ${yearAndMonthToString(_month)}"),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => new MonthPickerDialog(
                              initialMonth: _month,
                              onConfirm: (month) {
                                Navigator.of(context).pop();
                                setState(() {
                                  _month = month;
                                });
                              },
                            ),
                      );
                    },
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("First Weekday"),
                    trailing: new WeekdayDropDownButton(
                        value: _firstWeekday,
                        onChanged: (value) {
                          setState(() {
                            _firstWeekday = value;
                          });
                        }),
                  ),
                  new Divider(height: 0.0),
                  new CheckboxListTile(
                    title: new Text("Show Header"),
                    value: _shouldShowHeader,
                    onChanged: (value) {
                      setState(() {
                        _shouldShowHeader = value;
                      });
                    },
                  ),
                  new Divider(height: 0.0),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days Before"),
                    value: _showExtendedDaysBefore,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysBefore = value;
                      });
                    },
                  ),
                  new Divider(height: 0.0),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days After"),
                    value: _showExtendedDaysAfter,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysAfter = value;
                      });
                    },
                  ),
                  new Divider(height: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthViewHeaderItemBuilder(BuildContext context, int weekday) {
    return new Container(
      color: Colors.green[400],
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: new Center(
        child: new Text(weekdayToAbbreviatedString(weekday)),
      ),
    );
  }

  Widget _dayOfMonthBuilder(BuildContext context, DayOfMonth dayOfMonth) {
    return new Container(
      child: new Center(
        child: new Text(
          "${dayOfMonth.day.day}",
          style: new TextStyle(
            fontWeight:
                dayOfMonth.isExtended ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

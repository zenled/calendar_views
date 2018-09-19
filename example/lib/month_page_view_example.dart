import 'dart:async';

import 'package:flutter/material.dart';

import 'package:calendar_views/month_page_view.dart';

import 'axis_to_string.dart';
import 'page.dart';
import 'month_picker_dialog.dart';

class MonthPageViewExample extends StatefulWidget {
  @override
  _MonthPageViewExampleState createState() => new _MonthPageViewExampleState();
}

class _MonthPageViewExampleState extends State<MonthPageViewExample> {
  DateTime _minimumMonth;
  DateTime _maximumMonth;

  MonthPageController _monthPageController;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  @override
  void initState() {
    super.initState();

    DateTime now = new DateTime.now();
    _minimumMonth = now.add(new Duration(days: -40));
    _maximumMonth = now.add(new Duration(days: 40));

    _monthPageController = new MonthPageController(
      initialMonth: now,
    );

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;
  }

  void _onMonthChanged(DateTime month) {
    print(
      "Displaying: ${_monthToString(month)}",
    );
  }

  String _monthToString(DateTime month) {
    return "${month.year}.${month.month}";
  }

  void _changeMinimumMonth() {
    showDialog(
      context: context,
      builder: (context) => new MonthPickerDialog(
            initialMonth: _minimumMonth,
            onConfirm: (newMinimumMonth) {
              Navigator.of(context).pop();
              setState(() {
                _minimumMonth = newMinimumMonth;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MonthPageView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.green.shade200,
              child: new MonthPageView(
                minimumMonth: _minimumMonth,
                maximumMonth: _maximumMonth,
                controller: _monthPageController,
                pageBuilder: _monthPageBuilder,
                onMonthChanged: _onMonthChanged,
                scrollDirection: _scrollDirection,
                pageSnapping: _pageSnapping,
                reverse: _reverse,
              ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Jump To Today-Month"),
                      onPressed: () {
                        _monthPageController.jumpToMonth(
                          new DateTime.now(),
                        );
                      },
                    ),
                    new Divider(),
                    new ListTile(
                      title: new Text("Minimum Month"),
                      trailing: new Text(_monthToString(_minimumMonth)),
                      onTap: _changeMinimumMonth,
                    ),
                    new Divider(),
                    new Divider(),
                    new ListTile(
                      title: new Text("Scroll Direction"),
                      trailing: new DropdownButton<Axis>(
                        value: _scrollDirection,
                        items: <Axis>[Axis.horizontal, Axis.vertical]
                            .map((axis) => new DropdownMenuItem<Axis>(
                                  value: axis,
                                  child: new Text("${axisToString(axis)}"),
                                ))
                            .toList(),
                        onChanged: (Axis value) {
                          setState(() {
                            this._scrollDirection = value;
                          });
                        },
                      ),
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      title: new Text("Page snapping"),
                      value: _pageSnapping,
                      onChanged: (value) {
                        setState(() {
                          _pageSnapping = value;
                        });
                      },
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      title: new Text("Reverse"),
                      value: _reverse,
                      onChanged: (value) {
                        setState(() {
                          _reverse = value;
                        });
                      },
                    ),
                    new Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthPageBuilder(BuildContext context, DateTime month) {
    return new Page.forMonth(
      month: month,
    );
  }
}

//DateTime _addMonths(DateTime date, int numOfMonths) {
//  int yearChange = numOfMonths ~/ 12;
//  int monthChange = (numOfMonths.abs() % 12) * numOfMonths.sign;
//
//  int newYear = date.year + yearChange;
//  int newMonthBase0 = (date.month - 1) + monthChange;
//  if (newMonthBase0 > 11) {
//    newYear++;
//  }
//  if (newMonthBase0 < 0) {
//    newYear--;
//  }
//  newMonthBase0 = newMonthBase0 % 12;
//
//  return new DateTime(
//    newYear,
//    newMonthBase0 + 1,
//  );
//}

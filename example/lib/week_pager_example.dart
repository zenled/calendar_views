import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/week_pager.dart';

class WeekPagerExample extends StatefulWidget {
  @override
  _WeekPagerExampleState createState() => new _WeekPagerExampleState();
}

class _WeekPagerExampleState extends State<WeekPagerExample> {
  int _firstWeekday;

  bool _useInfinitePagerController;

  WeekPagerController _finitePagerController;

  WeekPagerController _infinitePagerController;

  @override
  void initState() {
    super.initState();

    _useInfinitePagerController = false;
    _firstWeekday = DateTime.monday;
    _createPageControllers();
  }

  void _createPageControllers() {
    DateTime now = new DateTime.now();

    _finitePagerController = new WeekPagerController(
      firstWeekday: _firstWeekday,
      initialWeek: now,
      minimumWeek: now.add(new Duration(days: -14)),
      maximumWeek: now.add(new Duration(days: 14)),
    );

    _infinitePagerController = new WeekPagerController(
      firstWeekday: _firstWeekday,
      initialWeek: now,
    );
  }

  WeekPagerController get _pagerController => _useInfinitePagerController
      ? _infinitePagerController
      : _finitePagerController;

  void _onPageChanged(List<DateTime> daysOnPage) {
    DateTime firstDayOfWeek = daysOnPage.first;

    print(
      "Displayed week: ${firstDayOfWeek.year}.${firstDayOfWeek
          .month}.${firstDayOfWeek.day}",
    );
  }

  String _weekdayToName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WeekPager Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              color: Colors.blue.shade200,
              child: new WeekPager(
                controller: _pagerController,
                pageBuilder: _pageBuilder,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new SingleChildScrollView(
              child: new Container(
                margin: new EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Jump to today-week"),
                      onPressed: () {
                        _pagerController.jumpTo(
                          new DateTime.now(),
                        );
                      },
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      title: new Text("Infinite WeekPager"),
                      subtitle: new Text(
                        "If true WeekPager will be infinite\n"
                            "if false it will be restricted to two weeks from last Monday",
                      ),
                      value: _useInfinitePagerController,
                      onChanged: (bool value) {
                        setState(() {
                          _useInfinitePagerController = value;
                        });
                      },
                    ),
                    new Divider(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text("First day of the week"),
                        new DropdownButton<int>(
                          value: _firstWeekday,
                          items: <int>[
                            DateTime.monday,
                            DateTime.tuesday,
                            DateTime.wednesday,
                            DateTime.thursday,
                            DateTime.friday,
                            DateTime.saturday,
                            DateTime.sunday,
                          ]
                              .map(
                                (weekday) => new DropdownMenuItem<int>(
                                      value: weekday,
                                      child: new Text(_weekdayToName(weekday)),
                                    ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _firstWeekday = value;
                              _createPageControllers();
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageBuilder(BuildContext context, List<DateTime> daysOfWeek) {
    return new Container(
      constraints: new BoxConstraints.expand(),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: daysOfWeek
            .map(
              (date) => new Text("${date.year}.${date.month}.${date.day}"),
            )
            .toList(),
      ),
    );
  }
}

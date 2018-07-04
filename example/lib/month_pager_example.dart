import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/month_pager.dart';

class MonthPagerExample extends StatefulWidget {
  @override
  _MonthPagerExampleState createState() => new _MonthPagerExampleState();
}

class _MonthPagerExampleState extends State<MonthPagerExample> {
  bool _useInfiniteMonthPagerController;

  MonthPagerController _finiteMonthPagerController;

  MonthPagerController _infiniteMonthPagerController;

  Axis _scrollDirection;

  bool _pageSnapping;

  @override
  void initState() {
    super.initState();

    _useInfiniteMonthPagerController = false;

    _scrollDirection = Axis.horizontal;

    _pageSnapping = true;

    DateTime now = new DateTime.now();
    DateTime nowMonth = new DateTime(now.year, now.month);

    DateTime twoMonthsBeforeNow = _addMonths(nowMonth, -2);

    DateTime twoMonthsAfterNow = _addMonths(nowMonth, 2);

    _finiteMonthPagerController = new MonthPagerController(
      initialMonth: nowMonth,
      minimumMonth: twoMonthsBeforeNow,
      maximumMonth: twoMonthsAfterNow,
    );

    _infiniteMonthPagerController = new MonthPagerController();
  }

  MonthPagerController get _monthPagerController =>
      _useInfiniteMonthPagerController
          ? _infiniteMonthPagerController
          : _finiteMonthPagerController;

  void _onMonthPageChanged(DateTime month) {
    print("Displaying ${month.year}.${month.month}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MonthPager Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.blue.shade200,
              child: new MonthPager(
                controller: _monthPagerController,
                scrollDirection: _scrollDirection,
                onPageChanged: _onMonthPageChanged,
                pageBuilder: _monthPagerPageBuilder,
                pageSnapping: _pageSnapping,
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
                      child: new Text("Jump to today-month"),
                      onPressed: () {
                        _monthPagerController.jumpTo(
                          new DateTime.now(),
                        );
                      },
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      value: _useInfiniteMonthPagerController,
                      title: new Text("Infinite MonthPager"),
                      subtitle: new Text(
                        "If true MonthPager will be infinite.\n"
                            "If false it will be restricted to two months from today-month.",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _useInfiniteMonthPagerController = value;
                        });
                      },
                    ),
                    new Divider(),
                    new ListTile(
                      title: new Text("Scroll Direction"),
                      trailing: new DropdownButton<Axis>(
                          value: _scrollDirection,
                          items: <Axis>[Axis.horizontal, Axis.vertical]
                              .map(
                                (axis) => new DropdownMenuItem<Axis>(
                                      value: axis,
                                      child: new Text("${_axisToString(axis)}"),
                                    ),
                              )
                              .toList(),
                          onChanged: (Axis value) {
                            setState(() {
                              this._scrollDirection = value;
                            });
                          }),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthPagerPageBuilder(BuildContext context, DateTime month) {
    return new Center(
      child: new Text("${month.year}.${month.month}"),
    );
  }
}

DateTime _addMonths(DateTime date, int numOfMonths) {
  int yearChange = numOfMonths ~/ 12;
  int monthChange = (numOfMonths.abs() % 12) * numOfMonths.sign;

  int newYear = date.year + yearChange;
  int newMonthBase0 = (date.month - 1) + monthChange;
  if (newMonthBase0 > 11) newYear++;
  if (newMonthBase0 < 0) newYear--;
  newMonthBase0 = newMonthBase0 % 12;

  return new DateTime(
    newYear,
    newMonthBase0 + 1,
  );
}

String _axisToString(Axis axis) {
  switch (axis) {
    case Axis.horizontal:
      return "Horizontal";
    case Axis.vertical:
      return "Vertical";
    default:
      return "Error";
  }
}

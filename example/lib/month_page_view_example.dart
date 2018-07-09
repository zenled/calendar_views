import 'package:flutter/material.dart';

import 'package:calendar_views/month_page_view.dart';

import 'axis_to_string.dart';
import 'page.dart';

class MonthPageViewExample extends StatefulWidget {
  @override
  _MonthPageViewExampleState createState() => new _MonthPageViewExampleState();
}

class _MonthPageViewExampleState extends State<MonthPageViewExample> {
  bool _bigText;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  bool _useInfiniteMonthPageController;
  MonthPageController _finiteMonthPageController;
  MonthPageController _infiniteMonthPageController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _useInfiniteMonthPageController = false;

    // initialise MonthPageController-s

    DateTime now = new DateTime.now();
    DateTime nowMonth = new DateTime(now.year, now.month);

    DateTime twoMonthsBeforeNow = _addMonths(nowMonth, -2);
    DateTime twoMonthsAfterNow = _addMonths(nowMonth, 2);

    _finiteMonthPageController = new MonthPageController(
      initialMonth: nowMonth,
      minimumMonth: twoMonthsBeforeNow,
      maximumMonth: twoMonthsAfterNow,
    );

    _infiniteMonthPageController = new MonthPageController();
  }

  MonthPageController get _monthPageController =>
      _useInfiniteMonthPageController
          ? _infiniteMonthPageController
          : _finiteMonthPageController;

  void _onMonthChanged(DateTime month) {
    print(
      "Displaying: "
          "${month.year.toString().padLeft(4, "0")}.${month.month
          .toString().padLeft(2, "0")}",
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
                scrollDirection: _scrollDirection,
                pageSnapping: _pageSnapping,
                reverse: _reverse,
                controller: _monthPageController,
                onMonthChanged: _onMonthChanged,
                pageBuilder: _monthPageBuilder,
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
                    new CheckboxListTile(
                      title: new Text("Big Text"),
                      subtitle: new Text(
                        "This is to demonstrate the that inner widgets of MonthPageView can be properly changed.",
                      ),
                      value: _bigText,
                      onChanged: (value) {
                        setState(() {
                          _bigText = value;
                        });
                      },
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      value: _useInfiniteMonthPageController,
                      title: new Text("Infinite MonthPageView"),
                      subtitle: new Text(
                        "If true MonthPageView will be infinite.\n"
                            "If false it will be restricted to two months from today-month.",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _useInfiniteMonthPageController = value;
                        });
                      },
                    ),
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
      bigText: _bigText,
      month: month,
    );
  }
}

DateTime _addMonths(DateTime date, int numOfMonths) {
  int yearChange = numOfMonths ~/ 12;
  int monthChange = (numOfMonths.abs() % 12) * numOfMonths.sign;

  int newYear = date.year + yearChange;
  int newMonthBase0 = (date.month - 1) + monthChange;
  if (newMonthBase0 > 11) {
    newYear++;
  }
  if (newMonthBase0 < 0) {
    newYear--;
  }
  newMonthBase0 = newMonthBase0 % 12;

  return new DateTime(
    newYear,
    newMonthBase0 + 1,
  );
}

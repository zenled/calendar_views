import 'package:flutter/material.dart';

import 'package:calendar_views/consecutive_days_page_view.dart';

import 'axis_to_string.dart';
import 'page.dart';

class ConsecutiveDaysPageViewExample extends StatefulWidget {
  @override
  _ConsecutiveDaysPageViewExampleState createState() =>
      new _ConsecutiveDaysPageViewExampleState();
}

class _ConsecutiveDaysPageViewExampleState
    extends State<ConsecutiveDaysPageViewExample> {
  bool _bigText;

  int _daysPerPage;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  bool _useInfiniteDaysPageController;
  ConsecutiveDaysPageController _finiteDaysPageController;
  ConsecutiveDaysPageController _infiniteDaysPageController;

  TextEditingController _daysPerPageTextController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _daysPerPage = 7;

    _daysPerPage = DateTime.daysPerWeek;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _useInfiniteDaysPageController = false;
    _createConsecutiveDaysPageControllers();

    _daysPerPageTextController =
        new TextEditingController(text: "$_daysPerPage");
  }

  void _createConsecutiveDaysPageControllers() {
    DateTime now = new DateTime.now();
    // using UTC to avoid problems with day light saving time when adding days
    DateTime nowUTC = new DateTime.utc(now.year, now.month, now.day);

    _finiteDaysPageController = new ConsecutiveDaysPageController(
      daysPerPage: _daysPerPage,
      initialDay: nowUTC,
      minimumDay: nowUTC.add(new Duration(days: -(_daysPerPage * 2))),
      maximumDay: nowUTC.add(new Duration(days: (_daysPerPage * 2))),
    );

    _infiniteDaysPageController = new ConsecutiveDaysPageController(
      daysPerPage: _daysPerPage,
      initialDay: nowUTC,
    );
  }

  ConsecutiveDaysPageController get _daysPageController =>
      _useInfiniteDaysPageController
          ? _infiniteDaysPageController
          : _finiteDaysPageController;

  void _onDaysChanged(List<DateTime> daysOnPage) {
    DateTime day = daysOnPage.first;

    print(
      "First day of displayed days: "
          "${day.year.toString().padLeft(4, "0")}.${day.month.toString()
          .padLeft(2, "0")}.${day
          .day.toString().padLeft(2, "0")}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ConsecutiveDaysPageView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              color: Colors.green.shade200,
              child: new ConsecutiveDaysPageView(
                scrollDirection: _scrollDirection,
                pageSnapping: _pageSnapping,
                reverse: _reverse,
                controller: _daysPageController,
                onDaysChanged: _onDaysChanged,
                pageBuilder: _daysPageBuilder,
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
                    new Divider(),
                    new RaisedButton(
                        child: new Text("Jump To Today"),
                        onPressed: () {
                          _daysPageController.jumpToDay(
                            new DateTime.now(),
                          );
                        }),
                    new Divider(),
                    new ListTile(
                      title: new Text("Days Per Page"),
                      trailing: new Container(
                        width: 40.0,
                        child: new TextField(
                          controller: _daysPerPageTextController,
                          textAlign: TextAlign.center,
                          autocorrect: false,
                          keyboardType: TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          onSubmitted: (value) {
                            int intValue = int.parse(value);

                            if (intValue != null && intValue >= 1) {
                              setState(() {
                                _daysPerPage = intValue;
                                _createConsecutiveDaysPageControllers();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      title: new Text("Big Text"),
                      subtitle: new Text(
                        "This is to demonstrate that the inner widgets of ConsecutiveDaysPageView can be properly changed.",
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
                      value: _useInfiniteDaysPageController,
                      title: new Text("Infinite ConsecutiveDaysPageView"),
                      subtitle: new Text(
                        "If true ConsecutiveDaysPageView will be infinite.\n"
                            "If false it will be restricted to two pages from today.",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _useInfiniteDaysPageController = value;
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
                          }),
                    ),
                    new Divider(),
                    new CheckboxListTile(
                      title: new Text("Page Snapping"),
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

  Widget _daysPageBuilder(BuildContext context, List<DateTime> days) {
    return new Page.forMultipleDays(
      bigText: _bigText,
      days: days,
    );
  }
}

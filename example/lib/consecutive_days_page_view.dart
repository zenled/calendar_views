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
  final _initialDaysPerPage = 7;

  bool _bigText;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  ConsecutiveDaysPageController _daysPageController;

  TextEditingController _daysPerPageTextController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _createDaysPageController();

    _daysPerPageTextController =
        new TextEditingController(text: "$_initialDaysPerPage");
  }

  String get _minimumDayText => _dateToString(_daysPageController.minimumDay);

  String get _maximumDayText => _dateToString(_daysPageController.maximumDay);

  String _dateToString(DateTime date) {
    return "${date.year}.${date.month}.${date.day}";
  }

  void _createDaysPageController() {
    DateTime now = new DateTime.now();
    // using UTC to avoid problems with day light saving time when adding days
    DateTime nowUTC = new DateTime.utc(now.year, now.month, now.day);

    _daysPageController = new ConsecutiveDaysPageController(
      daysPerPage: _initialDaysPerPage,
      initialDay: nowUTC,
      minimumDay: nowUTC.add(new Duration(days: -(_initialDaysPerPage * 2))),
      maximumDay: nowUTC.add(new Duration(days: (_initialDaysPerPage * 2) - 1)),
    );
  }

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
                margin: new EdgeInsets.symmetric(vertical: 16.0),
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
                            int newDaysPerPage = int.parse(value);

                            if (newDaysPerPage != null && newDaysPerPage >= 1) {
                              ConsecutiveDaysPageController
                                  _newDaysPageController = _daysPageController
                                      .copyWith(daysPerPage: newDaysPerPage);

                              setState(() {
                                _daysPageController = _newDaysPageController;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    new Divider(height: 0.0),
                    new ListTile(
                      title: new Text("Minimum Day"),
                      trailing: new Text(_minimumDayText),
                      onTap: () async {
                        DateTime newMinimumDay = await showDatePicker(
                          context: context,
                          initialDate: _daysPageController.minimumDay,
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        if (newMinimumDay == null) return;

                        try {
                          ConsecutiveDaysPageController newDaysPageController =
                              _daysPageController.copyWith(
                            minimumDay: newMinimumDay,
                          );

                          setState(() {
                            _daysPageController = newDaysPageController;
                          });
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => new AlertDialog(
                                  title: new Text("Error"),
                                  content: new Text("$e"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                    ),
                    new Divider(height: 0.0),
                    new ListTile(
                      title: new Text("MaximumDay"),
                      trailing: new Text(_maximumDayText),
                      onTap: () async {
                        DateTime newMaximumDay = await showDatePicker(
                          context: context,
                          initialDate: _daysPageController.maximumDay,
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        if (newMaximumDay == null) return;

                        try {
                          ConsecutiveDaysPageController newDaysPageController =
                              _daysPageController.copyWith(
                            maximumDay: newMaximumDay,
                          );

                          setState(() {
                            _daysPageController = newDaysPageController;
                          });
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => new AlertDialog(
                                  title: new Text("Error"),
                                  content: new Text("$e"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                    ),
                    new Divider(
                      height: 0.0,
                    ),
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

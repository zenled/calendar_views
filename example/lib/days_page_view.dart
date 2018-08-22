import 'package:flutter/material.dart';

import 'package:calendar_views/days_page_view.dart';

import 'axis_to_string.dart';
import 'page.dart';

class DaysPageViewExample extends StatefulWidget {
  @override
  _DaysPageViewExampleState createState() => new _DaysPageViewExampleState();
}

class _DaysPageViewExampleState extends State<DaysPageViewExample> {
  bool _bigText;

  DaysConstraints _daysConstraints;
  DateTime _initialDay;
  DaysPageController _daysPageController;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  TextEditingController _daysPerPageTextController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _initialDay = new DateTime.now().toUtc();
    _daysConstraints = new DaysConstraints.forWeeks(
      dayInMinimumWeek: _initialDay.add(new Duration(days: -7)),
      dayInMaximumWeek: _initialDay.add(new Duration(days: 7)),
    );
    _daysPageController = new DaysPageController(
      initialDay: _initialDay,
    );

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _daysPerPageTextController = new TextEditingController(
      text: "${_daysConstraints.daysPerPage}",
    );
  }

  String get _minimumDayText => _dateToString(_daysConstraints.minimumDay);

  String get _maximumDayText {
    DateTime maximumDay = _daysConstraints.maximumDay;

    if (maximumDay != null) {
      return _dateToString(maximumDay);
    } else {
      return "Infinite";
    }
  }

  String _dateToString(DateTime date) {
    return "${date.year.toString().padLeft(4)}.${date.month.toString().padLeft(
        2)}.${date.day.toString().padLeft(2)}";
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
            title: new Text("Error"),
            content: new Text("$message"),
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

  void _onDaysChanged(List<DateTime> daysOnPage) {
    DateTime firstDayOfPage = daysOnPage.first;

    print("First day of displayed days: ${_dateToString(firstDayOfPage)}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DaysPageView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.green.shade200,
              child: new DaysPageView(
                constraints: _daysConstraints,
                controller: _daysPageController,
                pageBuilder: _daysPageBuilder,
                onDaysChanged: _onDaysChanged,
                scrollDirection: _scrollDirection,
                pageSnapping: _pageSnapping,
                reverse: _reverse,
              ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Container(
                margin: new EdgeInsets.symmetric(vertical: 16.0),
                child: new Column(
                  children: <Widget>[
                    new Divider(),
                    new RaisedButton(
                        child: new Text("Jump To Today"),
                        onPressed: () {
                          _daysPageController.jumpToDay(new DateTime.now());
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

                            try {
                              setState(() {
                                _daysConstraints = _daysConstraints
                                    .copyWithDaysPerPage(newDaysPerPage);
                              });
                            } catch (e) {
                              _showErrorDialog(e.toString());
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
                          initialDate: _daysConstraints.minimumDay,
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        if (newMinimumDay == null) return;

                        try {
                          setState(() {
                            _daysConstraints = _daysConstraints
                                .copyWithMinimumDay(newMinimumDay);
                          });
                        } catch (e) {
                          _showErrorDialog(e.toString());
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
                          initialDate: _daysConstraints.maximumDay != null
                              ? _daysConstraints.maximumDay
                              : new DateTime.now(),
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        try {
                          setState(() {
                            _daysConstraints = _daysConstraints
                                .copyWithMaximumDay(newMaximumDay);
                          });
                        } catch (e) {
                          _showErrorDialog(e.toString());
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

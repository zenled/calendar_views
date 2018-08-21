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

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  DaysPageController _daysPageController;

  TextEditingController _daysPerPageTextController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _daysPageController = new DaysPageController.forWeeks(
      firstWeekday: DateTime.monday,
      dayInInitialWeek: new DateTime(2018, 8, 21),
      dayInMinimumWeek: new DateTime(2018, 8, 14),
      dayInMaximumWeek: new DateTime(2018, 8, 28),
    );

    _daysPerPageTextController =
        new TextEditingController(text: "${_daysPageController.daysPerPage}");
  }

  String get _minimumDayText => _dateToString(_daysPageController.minimumDay);

  String get _maximumDayText {
    DateTime maximumDay = _daysPageController.maximumDay;

    if (maximumDay != null) {
      return _dateToString(maximumDay);
    } else {
      return "Unbounded";
    }
  }

  String _dateToString(DateTime date) {
    return "${date.year}.${date.month}.${date.day}";
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
        title: new Text("DaysPageView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              color: Colors.green.shade200,
              child: new DaysPageView(
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

                            try {
                              _daysPageController
                                  .changeDaysPerPage(newDaysPerPage);
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
                          initialDate: _daysPageController.minimumDay,
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        if (newMinimumDay == null) return;

                        try {
                          _daysPageController.changeMinimumDay(newMinimumDay);
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
                          initialDate: _daysPageController.maximumDay,
                          firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: new DateTime(2100),
                        );

                        if (newMaximumDay == null) return;

                        try {
                          _daysPageController.changeMaximumDay(newMaximumDay);
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

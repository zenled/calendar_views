import 'package:flutter/material.dart';

import 'package:calendar_views/day_page_view.dart';

import 'axis_to_string.dart';
import 'page.dart';

class DayPageViewExample extends StatefulWidget {
  @override
  State createState() => new _DayPageViewExampleState();
}

class _DayPageViewExampleState extends State<DayPageViewExample> {
  bool _bigText;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  bool _useInfiniteDayPageController;
  DayPageController _finiteDayPagerController;
  DayPageController _infiniteDayPagerController;

  @override
  void initState() {
    super.initState();

    _bigText = false;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _useInfiniteDayPageController = false;

    // initialise DayPageController-s

    DateTime initialDate = new DateTime.now();

    _finiteDayPagerController = new DayPageController(
      initialDay: initialDate,
      minimumDay: initialDate.add(new Duration(days: -2)),
      maximumDay: initialDate.add(new Duration(days: 2)),
    );

    _infiniteDayPagerController = new DayPageController();
  }

  DayPageController get _dayPageController => _useInfiniteDayPageController
      ? _infiniteDayPagerController
      : _finiteDayPagerController;

  void _onDayChanged(DateTime day) {
    print(
      "Displaying: "
          "${day.year.toString().padLeft(4, "0")}.${day.month
          .toString().padLeft(2, "0")}.${day
          .day.toString().padLeft(2, "0")}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DayPageView Example"),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                color: Colors.green.shade200,
                child: new DayPageView(
                  scrollDirection: _scrollDirection,
                  pageSnapping: _pageSnapping,
                  reverse: _reverse,
                  controller: _dayPageController,
                  onDayChanged: _onDayChanged,
                  pageBuilder: _dayPageBuilder,
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
                        child: new Text("Jump To Today"),
                        onPressed: () {
                          _dayPageController.jumpToDay(
                            new DateTime.now(),
                          );
                        },
                      ),
                      new Divider(),
                      new CheckboxListTile(
                        title: new Text("Big Text"),
                        subtitle: new Text(
                          "This is to demonstrate that the inner widgets of DayPageView can be properly changed.",
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
                        value: _useInfiniteDayPageController,
                        title: new Text("Infinite DayPageView"),
                        subtitle: new Text(
                          "If true DayPageView will be infinite.\n"
                              "If false it will be restricted to two days from today.",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _useInfiniteDayPageController = value;
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
        );
      }),
    );
  }

  Widget _dayPageBuilder(BuildContext context, DateTime day) {
    return new Page.forSingleDay(
      bigText: _bigText,
      day: day,
    );
  }
}

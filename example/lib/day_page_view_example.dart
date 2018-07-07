import 'package:flutter/material.dart';

import 'package:calendar_views/day_page_view.dart';

import 'axis_to_string.dart';

class DayPageViewExample extends StatefulWidget {
  @override
  State createState() => new _DayPageViewExampleState();
}

class _DayPageViewExampleState extends State<DayPageViewExample> {
  bool _useInfiniteDayPageController;

  DayPageController _finiteDayPagerController;
  DayPageController _infiniteDayPagerController;

  Axis _scrollDirection;
  bool _pageSnapping;

  @override
  void initState() {
    super.initState();

    _useInfiniteDayPageController = false;

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;

    DateTime initialDate = new DateTime.now();

    _finiteDayPagerController = new DayPageController(
      initialDay: initialDate,
      minimumDay: initialDate.add(new Duration(days: -2)),
      maximumDay: initialDate.add(new Duration(days: 2)),
    );

    _infiniteDayPagerController = new DayPageController();
  }

  DayPageController get _dayPagerController => _useInfiniteDayPageController
      ? _infiniteDayPagerController
      : _finiteDayPagerController;

  void _onDayChanged(DateTime day) {
    print("${day.year}.${day.month}.${day.day}");
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
                  controller: _dayPagerController,
                  pageSnapping: _pageSnapping,
                  scrollDirection: _scrollDirection,
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
                          _dayPagerController.jumpToDay(
                            new DateTime.now(),
                          );
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
                                .map(
                                  (axis) => new DropdownMenuItem<Axis>(
                                        value: axis,
                                        child:
                                            new Text("${axisToString(axis)}"),
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
        );
      }),
    );
  }

  Widget _dayPageBuilder(BuildContext context, DateTime day) {
    return new Center(
      child: new Text(
        "${day.year}.${day.month}.${day.day}",
      ),
    );
  }
}

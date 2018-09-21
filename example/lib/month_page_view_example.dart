import 'package:flutter/material.dart';

import 'package:calendar_views/month_page_view.dart';

import 'utils/all.dart';

class MonthPageViewExample extends StatefulWidget {
  @override
  _MonthPageViewExampleState createState() => new _MonthPageViewExampleState();
}

class _MonthPageViewExampleState extends State<MonthPageViewExample> {
  MonthPageController _monthPageController;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  String _displayedMonthText;

  @override
  void initState() {
    super.initState();

    DateTime initialMonth = new DateTime.now();

    _monthPageController = new MonthPageController(
      initialMonth: initialMonth,
    );

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _displayedMonthText = yearAndMonthToString(initialMonth);
  }

  void _onMonthChanged(DateTime month) {
    setState(() {
      _displayedMonthText = yearAndMonthToString(month);
    });
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
                pageBuilder: _monthPageBuilder,
                onMonthChanged: _onMonthChanged,
              ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Center(
                      child: new Text("Displayed month: $_displayedMonthText"),
                    ),
                  ),
                  new Divider(height: 0.0),
                  new Container(
                    padding: new EdgeInsets.all(4.0),
                    child: new Center(
                      child: new RaisedButton(
                        child: new Text("Jump To Today-Month"),
                        onPressed: () {
                          _monthPageController.jumpToMonth(
                            new DateTime.now(),
                          );
                        },
                      ),
                    ),
                  ),
                  new Divider(height: 0.0),
                  new ListTile(
                    title: new Text("Scroll Direction"),
                    trailing: new DropdownButton<Axis>(
                      value: _scrollDirection,
                      items: <Axis>[Axis.horizontal, Axis.vertical]
                          .map(
                            (axis) => new DropdownMenuItem<Axis>(
                                  value: axis,
                                  child: new Text("${axisToString(axis)}"),
                                ),
                          )
                          .toList(),
                      onChanged: (Axis value) {
                        setState(() {
                          this._scrollDirection = value;
                        });

                        showScrollDirectionChangeMightNotWorkDialog(
                          context: context,
                        );
                      },
                    ),
                  ),
                  new Divider(height: 0.0),
                  new CheckboxListTile(
                    title: new Text("Page snapping"),
                    value: _pageSnapping,
                    onChanged: (value) {
                      setState(() {
                        _pageSnapping = value;
                      });
                    },
                  ),
                  new Divider(height: 0.0),
                  new CheckboxListTile(
                    title: new Text("Reverse"),
                    value: _reverse,
                    onChanged: (value) {
                      setState(() {
                        _reverse = value;
                      });
                    },
                  ),
                ],
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

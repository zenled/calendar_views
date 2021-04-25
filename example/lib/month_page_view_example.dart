import 'package:calendar_views/month_page_view.dart';
import 'package:flutter/material.dart';

import 'utils/all.dart';

class MonthPageViewExample extends StatefulWidget {
  @override
  _MonthPageViewExampleState createState() => _MonthPageViewExampleState();
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

    DateTime initialMonth = DateTime.now();

    _monthPageController = MonthPageController(
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
    return Scaffold(
      appBar: AppBar(
        title: Text("MonthPageView Example"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green.shade200,
              child: MonthPageView(
                scrollDirection: _scrollDirection,
                pageSnapping: _pageSnapping,
                reverse: _reverse,
                controller: _monthPageController,
                pageBuilder: _monthPageBuilder,
                onMonthChanged: _onMonthChanged,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text("Displayed month: $_displayedMonthText"),
                    ),
                  ),
                  Divider(height: 0.0),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: ElevatedButton(
                        child: Text("Jump To Today-Month"),
                        onPressed: () {
                          _monthPageController.jumpToMonth(
                            DateTime.now(),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(height: 0.0),
                  ListTile(
                    title: Text("Scroll Direction"),
                    trailing: DropdownButton<Axis>(
                      value: _scrollDirection,
                      items: <Axis>[Axis.horizontal, Axis.vertical]
                          .map(
                            (axis) => DropdownMenuItem<Axis>(
                              value: axis,
                              child: Text("${axisToString(axis)}"),
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
                  Divider(height: 0.0),
                  CheckboxListTile(
                    title: Text("Page snapping"),
                    value: _pageSnapping,
                    onChanged: (value) {
                      setState(() {
                        _pageSnapping = value;
                      });
                    },
                  ),
                  Divider(height: 0.0),
                  CheckboxListTile(
                    title: Text("Reverse"),
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
    return DatePage.forMonth(
      month: month,
    );
  }
}

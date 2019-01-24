import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/days_page_view.dart';

import 'utils/all.dart';

class DaysPageViewExample extends StatefulWidget {
  @override
  _DaysPageViewExampleState createState() => new _DaysPageViewExampleState();
}

class _DaysPageViewExampleState extends State<DaysPageViewExample> {
  DaysPageController _daysPageController;

  Axis _scrollDirection;
  bool _pageSnapping;
  bool _reverse;

  bool _isInitialisingDaysPageController;

  @override
  void initState() {
    super.initState();

    _scrollDirection = Axis.horizontal;
    _pageSnapping = true;
    _reverse = false;

    _isInitialisingDaysPageController = false;
  }

  Future<void> _startInitialisationOfDaysPageController() async {
    if (_isInitialisingDaysPageController) {
      return false;
    }

    _isInitialisingDaysPageController = true;
    await new Future.delayed(Duration.zero);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new _DaysPageControllerInitialisationDialog(
            onConfirm: (controller) {
              Navigator.of(context).pop();
              setState(() {
                _daysPageController = controller;
              });
            },
          ),
    );

    setState(() {
      _isInitialisingDaysPageController = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_daysPageController == null) {
      _startInitialisationOfDaysPageController();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DaysPageView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.green[200],
              child: _daysPageController == null
                  ? null
                  : new DaysPageView(
                      scrollDirection: _scrollDirection,
                      pageSnapping: _pageSnapping,
                      reverse: _reverse,
                      controller: _daysPageController,
                      pageBuilder: _daysPageBuilder,
                    ),
            ),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Center(
                      child: new Text(
                        "DaysPerPage: ${_daysPageController?.daysPerPage ?? ""}",
                      ),
                    ),
                  ),
                  new Divider(height: 0.0),
                  new Container(
                    padding: new EdgeInsets.all(4.0),
                    child: new Center(
                      child: new RaisedButton(
                        child: new Text("Jump To Today"),
                        onPressed: () {
                          _daysPageController.jumpToDay(new DateTime.now());
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
                    title: new Text("Page Snapping"),
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

  Widget _daysPageBuilder(BuildContext context, List<DateTime> days) {
    return new Page.forDays(
      days: days,
    );
  }
}

class _DaysPageControllerInitialisationDialog extends StatefulWidget {
  _DaysPageControllerInitialisationDialog({
    @required this.onConfirm,
  }) : assert(onConfirm != null);

  final ValueChanged<DaysPageController> onConfirm;

  @override
  State createState() => new _DaysPageControllerInitialisationDialogState();
}

class _DaysPageControllerInitialisationDialogState
    extends State<_DaysPageControllerInitialisationDialog> {
  DateTime _firstDayOfInitialPage;
  int _daysPerPage;

  @override
  void initState() {
    super.initState();

    _firstDayOfInitialPage = new DateTime.now();
    _daysPerPage = DateTime.daysPerWeek;
  }

  Future<void> _changeFirstDayOfInitialPage() async {
    DateTime newFirstDayOfInitialPage = await showDatePicker(
      context: context,
      initialDate: _firstDayOfInitialPage,
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2100),
    );

    if (newFirstDayOfInitialPage == null) {
      return;
    }

    setState(() {
      _firstDayOfInitialPage = newFirstDayOfInitialPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("DaysPageController initialisation"),
      content: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("First Day Of Initial Page"),
              trailing: new RaisedButton(
                child: new Text("${dateToString(_firstDayOfInitialPage)}"),
                onPressed: () {
                  _changeFirstDayOfInitialPage();
                },
              ),
            ),
            new Divider(height: 0.0),
            new ListTile(
              title: new Text("Days Per Page"),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.remove_circle_outline),
                    onPressed: _daysPerPage > 1
                        ? () {
                            setState(() {
                              _daysPerPage--;
                            });
                          }
                        : null,
                  ),
                  new Text("$_daysPerPage"),
                  new IconButton(
                    icon: new Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _daysPerPage++;
                      });
                    },
                  )
                ],
              ),
            ),
            new Divider(height: 0.0),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () {
            widget.onConfirm(
              new DaysPageController(
                firstDayOnInitialPage: _firstDayOfInitialPage,
                daysPerPage: _daysPerPage,
              ),
            );
          },
        ),
      ],
    );
  }
}

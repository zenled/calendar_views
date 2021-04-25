import 'dart:async';

import 'package:calendar_views/days_page_view.dart';
import 'package:flutter/material.dart';

import 'utils/all.dart';

class DaysPageViewExample extends StatefulWidget {
  @override
  _DaysPageViewExampleState createState() => _DaysPageViewExampleState();
}

class _DaysPageViewExampleState extends State<DaysPageViewExample> {
  DaysPageController? _daysPageController;

  Axis? _scrollDirection;
  bool? _pageSnapping;
  bool? _reverse;

  late bool _isInitialisingDaysPageController;

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
      return;
    }

    _isInitialisingDaysPageController = true;
    await Future.delayed(Duration.zero);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DaysPageControllerInitialisationDialog(
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

    return Scaffold(
      appBar: AppBar(
        title: Text("DaysPageView Example"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green[200],
              child: _daysPageController == null
                  ? null
                  : DaysPageView(
                      scrollDirection: _scrollDirection!,
                      pageSnapping: _pageSnapping!,
                      reverse: _reverse!,
                      controller: _daysPageController!,
                      pageBuilder: _daysPageBuilder,
                    ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        "DaysPerPage: ${_daysPageController?.daysPerPage ?? ""}",
                      ),
                    ),
                  ),
                  Divider(height: 0.0),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: ElevatedButton(
                        child: Text("Jump To Today"),
                        onPressed: () {
                          _daysPageController!.jumpToDay(DateTime.now());
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
                      onChanged: (Axis? value) {
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
                    title: Text("Page Snapping"),
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

  Widget _daysPageBuilder(BuildContext context, List<DateTime> days) {
    return DatePage.forDays(
      days: days,
    );
  }
}

class _DaysPageControllerInitialisationDialog extends StatefulWidget {
  _DaysPageControllerInitialisationDialog({
    required this.onConfirm,
  });

  final ValueChanged<DaysPageController> onConfirm;

  @override
  State createState() => _DaysPageControllerInitialisationDialogState();
}

class _DaysPageControllerInitialisationDialogState
    extends State<_DaysPageControllerInitialisationDialog> {
  late DateTime _firstDayOfInitialPage;
  late int _daysPerPage;

  @override
  void initState() {
    super.initState();

    _firstDayOfInitialPage = DateTime.now();
    _daysPerPage = DateTime.daysPerWeek;
  }

  Future<void> _changeFirstDayOfInitialPage() async {
    DateTime? newFirstDayOfInitialPage = await showDatePicker(
      context: context,
      initialDate: _firstDayOfInitialPage,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
    return AlertDialog(
      title: Text("DaysPageController initialisation"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("First Day Of Initial Page"),
              trailing: ElevatedButton(
                child: Text("${dateToString(_firstDayOfInitialPage)}"),
                onPressed: () {
                  _changeFirstDayOfInitialPage();
                },
              ),
            ),
            Divider(height: 0.0),
            ListTile(
              title: Text("Days Per Page"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: _daysPerPage > 1
                        ? () {
                            setState(() {
                              _daysPerPage--;
                            });
                          }
                        : null,
                  ),
                  Text("$_daysPerPage"),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _daysPerPage++;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(height: 0.0),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            widget.onConfirm(
              DaysPageController(
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

import 'package:calendar_views/month_view.dart';
import 'package:flutter/material.dart';

import 'utils/all.dart';

class MonthViewExample extends StatefulWidget {
  @override
  _MonthViewExampleState createState() => _MonthViewExampleState();
}

class _MonthViewExampleState extends State<MonthViewExample> {
  DateTime _month;
  int _firstWeekday;

  bool _shouldShowHeader;

  bool _showExtendedDaysBefore;
  bool _showExtendedDaysAfter;

  @override
  void initState() {
    super.initState();

    _month = DateTime.now();
    _firstWeekday = DateTime.monday;

    _shouldShowHeader = true;

    _showExtendedDaysBefore = true;
    _showExtendedDaysAfter = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MonthView Example"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green.shade200,
              child: MonthView(
                month: _month,
                firstWeekday: _firstWeekday,
                dayOfMonthBuilder: _dayOfMonthBuilder,
                headerItemBuilder:
                    _shouldShowHeader ? _monthViewHeaderItemBuilder : null,
                showExtendedDaysBefore: _showExtendedDaysBefore,
                showExtendedDaysAfter: _showExtendedDaysAfter,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text("Month: ${yearAndMonthToString(_month)}"),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => MonthPickerDialog(
                          initialMonth: _month,
                          onConfirm: (month) {
                            Navigator.of(context).pop();
                            setState(() {
                              _month = month;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  Divider(height: 0.0),
                  ListTile(
                    title: Text("First Weekday"),
                    trailing: WeekdayDropDownButton(
                        value: _firstWeekday,
                        onChanged: (value) {
                          setState(() {
                            _firstWeekday = value;
                          });
                        }),
                  ),
                  Divider(height: 0.0),
                  CheckboxListTile(
                    title: Text("Show Header"),
                    value: _shouldShowHeader,
                    onChanged: (value) {
                      setState(() {
                        _shouldShowHeader = value;
                      });
                    },
                  ),
                  Divider(height: 0.0),
                  CheckboxListTile(
                    title: Text("Show Extended Days Before"),
                    value: _showExtendedDaysBefore,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysBefore = value;
                      });
                    },
                  ),
                  Divider(height: 0.0),
                  CheckboxListTile(
                    title: Text("Show Extended Days After"),
                    value: _showExtendedDaysAfter,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysAfter = value;
                      });
                    },
                  ),
                  Divider(height: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthViewHeaderItemBuilder(BuildContext context, int weekday) {
    return Container(
      color: Colors.green[400],
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Center(
        child: Text(weekdayToAbbreviatedString(weekday)),
      ),
    );
  }

  Widget _dayOfMonthBuilder(BuildContext context, DayOfMonth dayOfMonth) {
    return Container(
      child: Center(
        child: Text(
          "${dayOfMonth.day.day}",
          style: TextStyle(
            fontWeight:
                dayOfMonth.isExtended ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

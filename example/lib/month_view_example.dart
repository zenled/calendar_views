//import 'package:flutter/material.dart';
//import 'package:meta/meta.dart';
//
//import 'package:calendar_views/month_view.dart';
//import 'package:calendar_views/month_page_view.dart';
//
//import 'weekday_drop_down_button.dart';
//
//class MonthViewExample extends StatefulWidget {
//  @override
//  _MonthViewExampleState createState() => new _MonthViewExampleState();
//}
//
//class _MonthViewExampleState extends State<MonthViewExample> {
//  int _firstWeekday;
//
//  bool _showExtendedDaysBefore;
//  bool _showExtendedDaysAfter;
//
//  MonthPagerController _monthPagerController = new MonthPagerController();
//
//  @override
//  void initState() {
//    super.initState();
//
//    _firstWeekday = DateTime.monday;
//
//    _showExtendedDaysBefore = true;
//    _showExtendedDaysAfter = true;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("MonthView Example"),
//      ),
//      body: new Column(
//        children: <Widget>[
//          new Expanded(
//            child: new Container(
//              color: Colors.green.shade200,
//              child: new MonthView(
//                firstWeekday: _firstWeekday,
//                month: new DateTime.now(),
//                dayOfMonthBuilder: _dayOfMonthBuilder,
//                showExtendedDaysBefore: _showExtendedDaysBefore,
//                showExtendedDaysAfter: _showExtendedDaysAfter,
//              ),
//            ),
//          ),
//          new Expanded(
//            child: new SingleChildScrollView(
//              child: new Container(
//                padding: new EdgeInsets.all(16.0),
//                child: new Column(
//                  children: <Widget>[
//                    new ListTile(
//                      title: new Text("First WeekDay"),
//                      trailing: new WeekdayDropDownButton(
//                        value: _firstWeekday,
//                        onChanged: (value) {
//                          setState(() {
//                            _firstWeekday = value;
//                          });
//                        },
//                      ),
//                    ),
//                    new Divider(),
//                    new CheckboxListTile(
//                      title: new Text("Show Extended Days Before"),
//                      value: _showExtendedDaysBefore,
//                      onChanged: (value) {
//                        setState(() {
//                          _showExtendedDaysBefore = value;
//                        });
//                      },
//                    ),
//                    new Divider(),
//                    new CheckboxListTile(
//                      title: new Text("Show Extended Days After"),
//                      value: _showExtendedDaysAfter,
//                      onChanged: (value) {
//                        setState(() {
//                          _showExtendedDaysAfter = value;
//                        });
//                      },
//                    ),
//                    new Divider(),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _dayOfMonthBuilder(
//      BuildContext context, DayOfMonthProperties properties) {
//    return new Center(
//      child: new Text(
//        "${properties.date.day}",
//        style: new TextStyle(
//          fontWeight:
//              properties.isExtended ? FontWeight.normal : FontWeight.bold,
//        ),
//      ),
//    );
//  }
//}

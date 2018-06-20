import 'package:flutter/material.dart';

import 'package:calendar_views/day_pager.dart';

class DayPagerExample extends StatefulWidget {
  @override
  State createState() => new _DayPagerExampleState();
}

class _DayPagerExampleState extends State<DayPagerExample> {
  bool _useInfiniteDayPager;

  DayPagerController _finiteDayPagerController;

  DayPagerController _infiniteDayPagerController;

  @override
  void initState() {
    super.initState();

    DateTime initialDate = new DateTime.now();

    _useInfiniteDayPager = false;

    _finiteDayPagerController = new DayPagerController(
        initialDate: initialDate,
        minimumDate: initialDate.add(new Duration(days: -2)),
        maximumDate: initialDate.add(new Duration(days: 2)));

    _infiniteDayPagerController = new DayPagerController();
  }

  DayPagerController get _dayPagerController => _useInfiniteDayPager
      ? _infiniteDayPagerController
      : _finiteDayPagerController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Day Pager Example"),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new Column(
          children: <Widget>[
            new Expanded(
                child: new DayPager(
              controller: _dayPagerController,
              onPageChanged: (DateTime date) {
                print("Displaying: ${date.year}.${date.month}.${date.day}");
              },
              pageBuilder: _pageBuilder,
            )),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 16.0),
              child: new RaisedButton(
                child: new Text("Jump to today"),
                onPressed: () {
                  _dayPagerController.jumpTo(
                    new DateTime.now(),
                  );
                },
              ),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new CheckboxListTile(
                    title: new Text("Infinite DayPager"),
                    subtitle: new Text(
                      "If true DayPager will be infinite.\n"
                          "If false it will be restricted to two days from today.",
                    ),
                    value: _useInfiniteDayPager,
                    onChanged: (_) {
                      setState(() {
                        _useInfiniteDayPager = !_useInfiniteDayPager;
                      });
                    },
                  )
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 16.0),
              child: new RaisedButton(
                child: new Text("Print displayed date"),
                onPressed: () {
                  DateTime displayedDate = _dayPagerController.displayedDate;

                  print("Displaying: ${displayedDate.year}.${displayedDate
                      .month}.${displayedDate.day}");

                  Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text(
                            "Displaying: ${displayedDate.year}.${displayedDate
                            .month}.${displayedDate.day}"),
                      ));
                },
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _pageBuilder(BuildContext context, DateTime date) {
    return new Container(
      constraints: new BoxConstraints.expand(),
      color: Colors.green.shade200,
      child: new Center(
        child: new Text(
          "${date.year}.${date.month}.${date.day}",
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}

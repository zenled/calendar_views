import 'package:flutter/material.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/calendar_views.dart';

/// A simple widget that shows a checkbox some date-time information.
///
/// This widget uses [AutomaticKeepAliveClientMixin].
class Page extends StatefulWidget {
  Page.forSingleDay({
    @required DateTime day,
  })  : showDayOfMonth = true,
        days = <DateTime>[day];

  Page.forMultipleDays({
    @required this.days,
  }) : showDayOfMonth = true;

  Page.forMonth({
    @required DateTime month,
  })  : showDayOfMonth = false,
        days = <DateTime>[month];

  final bool showDayOfMonth;
  final List<DateTime> days;

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin<Page> {
  bool _isChecked;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _isChecked = false;
  }

  String _makeTextString(DateTime day) {
    String text = "${day.year.toString().padLeft(4, "0")}."
        "${day.month.toString().padLeft(2, "0")}";

    if (widget.showDayOfMonth) {
      text += ".${day.day.toString().padLeft(2, "0")}";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return new Container(
      constraints: new BoxConstraints.expand(),
      padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(4.0),
            child: new Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(
                    () {
                      _isChecked = value;
                    },
                  );
                }),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: widget.days
                    .map((day) => new Text(_makeTextString(day)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

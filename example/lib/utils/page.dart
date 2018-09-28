import 'package:flutter/material.dart';

import 'date_time_to_string.dart';

/// A simple widget that shows a checkbox and some date-time information.
///
/// This widget uses [AutomaticKeepAliveClientMixin].
class Page extends StatefulWidget {
  Page.forDays({
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
    if (widget.showDayOfMonth) {
      return dateToString(day);
    } else {
      return yearAndMonthToString(day);
    }
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
                  setState(() {
                    _isChecked = value;
                  });
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

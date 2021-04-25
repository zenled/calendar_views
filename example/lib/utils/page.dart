import 'package:flutter/material.dart';

import 'date_time_to_string.dart';

/// A simple widget that shows a checkbox and some date-time information.
///
/// This widget uses [AutomaticKeepAliveClientMixin].
class DatePage extends StatefulWidget {
  DatePage.forDays({
    required this.days,
  }) : showDayOfMonth = true;

  DatePage.forMonth({
    required DateTime month,
  })  : showDayOfMonth = false,
        days = <DateTime>[month];

  final bool showDayOfMonth;
  final List<DateTime> days;

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage>
    with AutomaticKeepAliveClientMixin<DatePage> {
  bool? _isChecked;

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

    return Container(
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            child: Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value;
                  });
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.days
                    .map((day) => Text(_makeTextString(day)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

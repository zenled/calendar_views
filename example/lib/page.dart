import 'package:flutter/material.dart';

import 'package:calendar_views/calendar_views.dart';

/// A simple widget to be displayed as page in examples of widgets that extend [CalendarPageView].
///
/// The easiest way to preserve state of this widget (eg. the scrollPosition)
/// is to use AutomaticKeepAliveClientMixin.
///
/// This is similar to preserving state in [PageView],
/// because inside [CalendarPageView] a [PageView] is used.
///
/// **Important**
///
/// If the [CalendarPageController.controller] or [CalendarPageView.scrollDirection] is changed at runtime,
/// the state will **always be lost**.
/// This will happen even when using [PageStorage] or [AutomaticKeepAliveClientMixin]
/// or similar page-storing solutions.
/// For more information on this issue check documentation of [CalendarPageView].
class Page extends StatefulWidget {
  Page.forSingleDay({
    @required this.bigText,
    @required DateTime day,
  })  : showDayOfMonth = true,
        days = <DateTime>[day];

  Page.forMultipleDays({
    @required this.bigText,
    @required this.days,
  }) : showDayOfMonth = true;

  Page.forMonth({
    @required this.bigText,
    @required DateTime month,
  })  : showDayOfMonth = false,
        days = <DateTime>[month];

  final bool bigText;

  final bool showDayOfMonth;
  final List<DateTime> days;

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin<Page> {
  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String _makeTextString(DateTime day) {
      String text = "${day.year.toString().padLeft(4, "0")}."
          "${day.month.toString().padLeft(2, "0")}";

      if (widget.showDayOfMonth) {
        text += ".${day.day.toString().padLeft(2, "0")}";
      }

      return text;
    }

    return new SingleChildScrollView(
      child: new Container(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Column(
          children: widget.days
              .map((day) => new Text(
                    _makeTextString(day),
                    style: widget.bigText
                        ? new TextStyle(fontSize: 50.0)
                        : new TextStyle(),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

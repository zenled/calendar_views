import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'day_of_month_builder.dart';
import 'day_of_month_properties.dart';

class MonthViewDay extends StatefulWidget {
  MonthViewDay({
    @required this.automaticallyRefresh,
    @required this.builder,
    @required this.properties,
  })  : assert(automaticallyRefresh != null),
        assert(builder != null),
        assert(properties != null);

  final bool automaticallyRefresh;

  final DayOfMonthBuilder builder;

  final DayOfMonthProperties properties;

  @override
  _MonthViewDayState createState() => new _MonthViewDayState();
}

class _MonthViewDayState extends State<MonthViewDay> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.properties);
  }
}

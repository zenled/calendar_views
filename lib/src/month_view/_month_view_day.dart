import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'day_of_month_builder.dart';
import 'day_of_month_properties.dart';

/// Widget that holds a day of month.
class MonthViewDay extends StatelessWidget {
  MonthViewDay({
    @required this.properties,
    @required this.builder,
    Key key,
  })  : assert(properties != null),
        assert(builder != null),
        super(key: key);

  /// Properties of day.
  final DayOfMonthProperties properties;

  /// Function that builds the contents of day.
  final DayOfMonthBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, properties);
  }
}

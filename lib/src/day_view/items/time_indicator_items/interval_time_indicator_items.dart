import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../day_view_item.dart';
import 'time_indicator_child_builder.dart';

class IntervalTimeIndicatorItems implements DayViewItem {
  IntervalTimeIndicatorItems({
    @required this.childBuilder,
  });

  final TimeIndicatorChildBuilder childBuilder;

  @override
  Positioned build(BuildContext context) {
    return new Positioned(child: new Text("TimeIndicator"));
  }
}

import 'package:flutter/material.dart';

import 'day_pager_example.dart';
import 'day_view_example.dart';
import 'month_pager_example.dart';
import 'month_view_example.dart';
import 'week_pager_example.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Calendar Views example",
      home: new MonthViewExample(),
    );
  }
}

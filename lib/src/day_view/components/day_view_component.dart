import 'package:flutter/material.dart';

@immutable
abstract class DayViewComponent {
  const DayViewComponent();

  List<Positioned> buildItems(BuildContext context);
}

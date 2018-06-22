import 'package:flutter/material.dart';

abstract class DayViewComponent {
  List<Positioned> buildItems(BuildContext context);
}

import 'package:flutter/material.dart';

/// Class that builds items (positioned widgets) that should be displayed inside a DayView.
@immutable
abstract class Component {
  const Component();

  List<Positioned> buildItems(BuildContext context);
}

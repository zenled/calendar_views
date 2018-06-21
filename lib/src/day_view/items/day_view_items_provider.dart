import 'package:flutter/material.dart';

import 'day_view_item.dart';

/// Inherited widget that provides [DayViewItem]s to DayView.
class DayViewItemsProvider extends InheritedWidget {
  DayViewItemsProvider({
    @required this.items,
    @required Widget child,
  })  : assert(items != null),
        super(child: child);

  /// List of items to be displayed inside a DayView.
  final List<DayViewItem> items;

  static DayViewItemsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewItemsProvider);
  }

  @override
  bool updateShouldNotify(DayViewItemsProvider oldWidget) {
    return oldWidget.items != items;
  }
}

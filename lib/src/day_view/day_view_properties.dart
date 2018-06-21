import 'package:flutter/material.dart';

import 'dimensions_positions/all.dart';
import 'items/all.dart';

class DayViewProperties extends StatefulWidget {
  DayViewProperties({
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 24 * 60,
    @required this.dimensions,
    @required this.items,
    @required this.child,
  })  : assert(minimumMinuteOfDay != null &&
            minimumMinuteOfDay >= 0 &&
            minimumMinuteOfDay <= (24 * 60 - 1)),
        assert(maximumMinuteOfDay != null &&
            maximumMinuteOfDay >= 1 &&
            maximumMinuteOfDay <= (24 * 60)),
        assert(dimensions != null),
        assert(items != null),
        assert(child != null);

  /// Minimum minute of day that the DayView will be able to Sdisplay (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day that the DayView will be able to display (inclusive).
  final int maximumMinuteOfDay;

  /// Dimensions (key points) of DayView.
  final DayViewDimensions dimensions;

  /// List of items to be displayed in DayView.
  final List<DayViewItem> items;

  /// Child of this widget
  final Widget child;

  @override
  _DayViewPropertiesState createState() => new _DayViewPropertiesState();
}

class _DayViewPropertiesState extends State<DayViewProperties> {
  @override
  Widget build(BuildContext context) {
    return new DayViewPositions(
      minimumMinuteOfDay: widget.minimumMinuteOfDay,
      maximumMinuteOfDay: widget.maximumMinuteOfDay,
      dimensions: widget.dimensions,
      child: new DayViewItemsProvider(
        items: widget.items,
        child: widget.child,
      ),
    );
  }
}

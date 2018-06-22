import 'package:flutter/material.dart';

import 'dimensions_positions/all.dart';
import 'components/all.dart';
import 'restrictions/all.dart';

/// Convenience widget that builds [DayViewRestrictions], [DayViewPositions] and [DayViewComponentsProvider].
class DayViewProperties extends StatefulWidget {
  DayViewProperties({
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 24 * 60,
    @required this.width,
    @required this.dimensions,
    @required this.items,
    @required this.child,
  })  : assert(minimumMinuteOfDay != null &&
            minimumMinuteOfDay >= 0 &&
            minimumMinuteOfDay <= (24 * 60 - 1)),
        assert(maximumMinuteOfDay != null &&
            maximumMinuteOfDay >= 1 &&
            maximumMinuteOfDay <= (24 * 60)),
        assert(width != null && width >= 0),
        assert(dimensions != null),
        assert(items != null),
        assert(child != null);

  /// Minimum minute of day that the DayView will be able to Sdisplay (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day that the DayView will be able to display (inclusive).
  final int maximumMinuteOfDay;

  /// Width of the dayView.
  final double width;

  /// Dimensions (key points) of DayView.
  final DayViewDimensions dimensions;

  /// List of components to be displayed in DayView.
  final List<DayViewComponent> items;

  /// Child of this widget
  final Widget child;

  @override
  _DayViewPropertiesState createState() => new _DayViewPropertiesState();
}

class _DayViewPropertiesState extends State<DayViewProperties> {
  @override
  Widget build(BuildContext context) {
    return new DayViewRestrictions(
      minimumMinuteOfDay: widget.minimumMinuteOfDay,
      maximumMinuteOfDay: widget.maximumMinuteOfDay,
      child: new DayViewPositions(
        minimumMinuteOfDay: widget.minimumMinuteOfDay,
        maximumMinuteOfDay: widget.maximumMinuteOfDay,
        dayViewWidth: widget.width,
        dimensions: widget.dimensions,
        child: new DayViewComponentsProvider(
          components: widget.items,
          child: widget.child,
        ),
      ),
    );
  }
}

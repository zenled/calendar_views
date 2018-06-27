import 'package:flutter/material.dart';

import 'package:calendar_views/src/day_view/components/components.dart';
import 'package:calendar_views/src/day_view/dimensions/dimensions.dart';
import 'package:calendar_views/src/day_view/positions/positions.dart';
import 'package:calendar_views/src/day_view/restrictions/restrictions.dart';

/// Convenience widget that builds [DayViewRestrictions], [DayViewPositions] and [DayViewComponentsProvider].
class DayViewProperties extends StatefulWidget {
  DayViewProperties({
    this.minimumMinuteOfDay = 0,
    this.maximumMinuteOfDay = 24 * 60,
    @required this.dimensions,
    @required this.components,
    @required this.child,
  })  : assert(minimumMinuteOfDay != null &&
            minimumMinuteOfDay >= 0 &&
            minimumMinuteOfDay <= (24 * 60 - 1)),
        assert(maximumMinuteOfDay != null &&
            maximumMinuteOfDay >= 1 &&
            maximumMinuteOfDay <= (24 * 60)),
        assert(dimensions != null),
        assert(components != null),
        assert(child != null);

  /// Minimum minute of day that the DayView will be able to Sdisplay (inclusive).
  final int minimumMinuteOfDay;

  /// Maximum minute of day that the DayView will be able to display (inclusive).
  final int maximumMinuteOfDay;

  /// Dimensions (key points) of DayView.
  final DayViewDimensions dimensions;

  /// List of components to be displayed in DayView.
  final List<DayViewComponent> components;

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
      child: new DayViewDimensionsProvider(
        dimensions: widget.dimensions,
        child: new DayViewPositionerGenerator(
          child: new DayViewComponentsProvider(
            components: widget.components,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

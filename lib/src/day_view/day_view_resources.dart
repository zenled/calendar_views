import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'components/all.dart';
import 'positioning_assistant/all.dart';
import 'properties/all.dart';

/// Convenience widget that builds [DayViewRestrictions], [DayViewPositions] and [DayViewComponentsProvider].
class DayViewResources extends StatefulWidget {
  DayViewResources({
    this.restrictions = const Restrictions(),
    this.dimensions = const Dimensions(),
    @required this.components,
    @required this.child,
  })  : assert(restrictions != null),
        assert(dimensions != null),
        assert(components != null),
        assert(child != null);

  /// Restrictions placed upon child DayViews.
  final Restrictions restrictions;

  /// Dimensions of child DayViews.
  final Dimensions dimensions;

  /// List of components to be displayed in child DayViews.
  final List<Component> components;

  /// Child of this widget
  final Widget child;

  @override
  _DayViewPropertiesState createState() => new _DayViewPropertiesState();
}

class _DayViewPropertiesState extends State<DayViewResources> {
  @override
  Widget build(BuildContext context) {
    return new RestrictionsProvider(
      restrictions: widget.restrictions,
      child: new DimensionsProvider(
        dimensions: widget.dimensions,
        child: new PositioningAssistantGenerator(
          child: new ComponentsProvider(
            components: widget.components,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

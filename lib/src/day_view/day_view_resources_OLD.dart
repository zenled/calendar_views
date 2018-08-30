import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'components_OLD/all.dart';
import 'properties/all.dart';
import 'day_view_OLD.dart';

/// Convenience widget that builds [RestrictionsOLD], [Dimensions] and [ComponentsProvider].
class DayViewResources extends StatefulWidget {
  DayViewResources({
    this.restrictions = const RestrictionsData(),
    this.dimensions = const DimensionsData(),
    @required this.components,
    @required this.child,
  })  : assert(restrictions != null),
        assert(dimensions != null),
        assert(components != null),
        assert(child != null);

  /// Restrictions placed upon child [DayViewOLD]s.
  final RestrictionsData restrictions;

  /// Dimensions of child [DayViewOLD]s.
  final DimensionsData dimensions;

  /// List of components to be displayed in child [DayViewOLD]s.
  final List<Component> components;

  final Widget child;

  @override
  _DayViewPropertiesState createState() => new _DayViewPropertiesState();
}

class _DayViewPropertiesState extends State<DayViewResources> {
  @override
  Widget build(BuildContext context) {
    return new RestrictionsOLD(
      restrictionsData: widget.restrictions,
      child: new Dimensions(
        dimensionsData: widget.dimensions,
        child: new ComponentsProvider(
          components: widget.components,
          child: widget.child,
        ),
      ),
    );
  }
}

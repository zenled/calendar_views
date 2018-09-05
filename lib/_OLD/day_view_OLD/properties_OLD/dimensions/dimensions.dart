import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'dimensions_data.dart';

/// Widget that propagates [DimensionsData].
class Dimensions extends InheritedWidget {
  Dimensions({
    @required this.dimensionsData,
    @required Widget child,
  })  : assert(dimensionsData != null),
        super(child: child);

  final DimensionsData dimensionsData;

  @override
  bool updateShouldNotify(Dimensions oldWidget) {
    return oldWidget.dimensionsData != dimensionsData;
  }

  static DimensionsData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Dimensions) as Dimensions)
        .dimensionsData;
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'dimensions.dart';

class DimensionsProvider extends InheritedWidget {
  DimensionsProvider({
    @required this.dimensions,
    @required Widget child,
  })  : assert(dimensions != null),
        super(child: child);

  final Dimensions dimensions;

  @override
  bool updateShouldNotify(DimensionsProvider oldWidget) {
    return oldWidget.dimensions != dimensions;
  }

  static Dimensions of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DimensionsProvider)
            as DimensionsProvider)
        .dimensions;
  }
}

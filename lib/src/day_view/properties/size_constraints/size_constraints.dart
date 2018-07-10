import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'size_constraints_data.dart';

/// Widget that propagates [SizeConstraintsData].
class SizeConstraints extends InheritedWidget {
  const SizeConstraints({
    @required this.sizeConstraintsData,
    @required Widget child,
  })  : assert(sizeConstraintsData != null),
        super(child: child);

  final SizeConstraintsData sizeConstraintsData;

  @override
  bool updateShouldNotify(SizeConstraints oldWidget) {
    return sizeConstraintsData != oldWidget.sizeConstraintsData;
  }

  static SizeConstraintsData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SizeConstraints)
            as SizeConstraints)
        .sizeConstraintsData;
  }
}

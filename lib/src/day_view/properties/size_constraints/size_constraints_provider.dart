import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'size_constraints.dart';

class SizeConstraintsProvider extends InheritedWidget {
  const SizeConstraintsProvider({
    @required this.sizeConstraints,
    @required Widget child,
  })  : assert(sizeConstraints != null),
        super(child: child);

  final SizeConstraints sizeConstraints;

  @override
  bool updateShouldNotify(SizeConstraintsProvider oldWidget) {
    return sizeConstraints != oldWidget.sizeConstraints;
  }

  static SizeConstraints of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SizeConstraintsProvider)
            as SizeConstraintsProvider)
        .sizeConstraints;
  }
}

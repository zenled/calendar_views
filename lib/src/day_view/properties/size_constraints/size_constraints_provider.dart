import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'size_constraints.dart';

class SizeConstraintsProvider extends InheritedWidget {
  const SizeConstraintsProvider({
    @required this.sizes,
    @required Widget child,
  })  : assert(sizes != null),
        super(child: child);

  final SizeConstraints sizes;

  @override
  bool updateShouldNotify(SizeConstraintsProvider oldWidget) {
    return sizes != oldWidget.sizes;
  }

  static SizeConstraints of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SizeConstraintsProvider)
            as SizeConstraintsProvider)
        .sizes;
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'restrictions_data.dart';

/// Widget that propagates [RestrictionsData].
class Restrictions extends InheritedWidget {
  Restrictions({
    @required this.restrictionsData,
    @required Widget child,
  })  : assert(restrictionsData != null),
        super(child: child);

  final RestrictionsData restrictionsData;

  @override
  bool updateShouldNotify(Restrictions oldWidget) {
    return restrictionsData != oldWidget.restrictionsData;
  }

  static RestrictionsData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Restrictions) as Restrictions)
        .restrictionsData;
  }
}

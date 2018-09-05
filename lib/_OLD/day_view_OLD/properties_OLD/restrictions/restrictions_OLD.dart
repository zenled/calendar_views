import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'restrictions_data.dart';

/// Widget that propagates [RestrictionsData].
class RestrictionsOLD extends InheritedWidget {
  RestrictionsOLD({
    @required this.restrictionsData,
    @required Widget child,
  })  : assert(restrictionsData != null),
        super(child: child);

  final RestrictionsData restrictionsData;

  @override
  bool updateShouldNotify(RestrictionsOLD oldWidget) {
    return restrictionsData != oldWidget.restrictionsData;
  }

  static RestrictionsData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(RestrictionsOLD)
            as RestrictionsOLD)
        .restrictionsData;
  }
}

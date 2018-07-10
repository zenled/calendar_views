import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'restrictions.dart';

/// Widget that propagates DayView [Restrictions] down the widget tree.
class RestrictionsProvider extends InheritedWidget {
  RestrictionsProvider({
    @required this.restrictions,
    @required Widget child,
  })  : assert(restrictions != null),
        super(child: child);

  final Restrictions restrictions;

  @override
  bool updateShouldNotify(RestrictionsProvider oldWidget) {
    return restrictions != oldWidget.restrictions;
  }

  static Restrictions of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(RestrictionsProvider)
            as RestrictionsProvider)
        .restrictions;
  }
}

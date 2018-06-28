import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'sizes.dart';

class SizesProvider extends InheritedWidget {
  const SizesProvider({
    @required this.sizes,
    @required Widget child,
  })  : assert(sizes != null),
        super(child: child);

  final Sizes sizes;

  @override
  bool updateShouldNotify(SizesProvider oldWidget) {
    return sizes != oldWidget.sizes;
  }

  static Sizes of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SizesProvider)
            as SizesProvider)
        .sizes;
  }
}

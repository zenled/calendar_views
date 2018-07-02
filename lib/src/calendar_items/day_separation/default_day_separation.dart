import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

Positioned defaultDaySeparationBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required DaySeparationProperties properties,
}) {
  return new Positioned(
    top: position.top,
    left: position.left,
    width: size.width,
    height: size.height,
    child: new DefaultDaySeparation(height: size.height),
  );
}

class DefaultDaySeparation extends StatelessWidget {
  const DefaultDaySeparation({
    this.width = 0.5,
    @required this.height,
    this.color = Colors.black,
  })  : assert(width != null),
        assert(height != null),
        assert(color != null);

  final double width;

  final double height;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

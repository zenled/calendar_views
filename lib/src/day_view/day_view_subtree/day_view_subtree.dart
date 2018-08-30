import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayViewSubtree extends StatefulWidget {
  DayViewSubtree({
    @required this.properties,
    this.widths = const Widths(),
    @required this.child,
  });

  final Properties properties;
  final Widths widths;

  final Widget child;

  @override
  State createState() => new _DayViewSubtreeState();
}

class _DayViewSubtreeState extends State<DayViewSubtree> {
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return new DayViewEssentials(
          properties: widget.properties,
          horizontalPositioner: new HorizontalPositioner(
            properties: widget.properties,
            widths: widget.widths,
            availableWidth: constraints.maxWidth,
          ),
          child: widget.child,
        );
      },
    );
  }
}

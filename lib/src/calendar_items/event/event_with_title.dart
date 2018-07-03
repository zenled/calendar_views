import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';
import 'package:calendar_views/day_view.dart';

Positioned eventWithTitleBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required ItemPosition position,
  @required ItemSize size,
  @required T event,
}) {
  return new Positioned(
    top: position.top,
    left: position.left,
    child: new EventWithTitle(
      size: new Size(size.width, size.height),
      title: (event as SimpleEvent).title,
    ),
  );
}

class EventWithTitle extends StatelessWidget {
  const EventWithTitle({
    @required this.size,
    this.color = Colors.lightGreen,
    @required this.title,
  })  : assert(size != null),
        assert(color != null),
        assert(title != null);

  final Size size;

  final Color color;

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size.width,
      height: size.height,
      child: new Container(
        color: color,
        margin: new EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
        child: new Center(
          child: new Text(title),
        ),
      ),
    );
  }
}

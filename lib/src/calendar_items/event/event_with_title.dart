import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

import '../position.dart';

Positioned eventWithTitleBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required T event,
}) {
  return new Positioned(
    top: position.top,
    left: position.left,
    child: new EventWithTitle(
      size: size,
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
      color: color,
      child: new Center(
        child: new Text(title),
      ),
    );
  }
}

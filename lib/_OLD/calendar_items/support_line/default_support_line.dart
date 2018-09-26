//import 'package:flutter/material.dart';
//import 'package:meta/meta.dart';
//
//import 'package:calendar_views/day_view_schedule.dart';
//
//Positioned defaultSupportLineBuilder({
//  @required BuildContext context,
//  @required ItemPosition position,
//  @required double width,
//  @required SupportLineProperties properties,
//}) {
//  return new Positioned(
//    top: position.top,
//    left: position.left,
//    width: width,
//    child: new DefaultSupportLine(),
//  );
//}
//
//class DefaultSupportLine extends StatelessWidget {
//  const DefaultSupportLine({
//    this.height = 0.5,
//    this.color = Colors.black,
//  })  : assert(height != null),
//        assert(color != null);
//
//  /// Height of the support line.
//  final double height;
//
//  /// Color of the support line.
//  final Color color;
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      constraints: new BoxConstraints.expand(height: height),
//      color: color,
//    );
//  }
//}

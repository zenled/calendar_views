//import 'package:flutter/material.dart';
//import 'package:meta/meta.dart';
//
//import 'package:calendar_views/day_view_schedule.dart';
//
//import 'package:calendar_views/src/day_view/components/item_position.dart';
//
///// Builder for [DefaultTimeIndicator].
//Positioned defaultTimeIndicatorBuilder({
//  @required BuildContext context,
//  @required ItemPosition position,
//  @required ItemSize size,
//  @required TimeIndicatorProperties properties,
//}) {
//  return new Positioned(
//    top: position.top,
//    left: position.left,
//    width: size.width,
//    height: size.height,
//    child: new DefaultTimeIndicator(
//      properties: properties,
//      size: new Size(size.width, size.height),
//      backgroundColor: Colors.yellow.shade200,
//    ),
//  );
//}
//
///// Default widget for a time indicator.
//class DefaultTimeIndicator extends StatelessWidget {
//  DefaultTimeIndicator({
//    @required this.properties,
//    @required this.size,
//    this.backgroundColor,
//  }) : assert(properties != null);
//
//  /// Properties of this time indicator.
//  final TimeIndicatorProperties properties;
//
//  /// Size of this time indicator.
//  final Size size;
//
//  /// Background color of this time indicator.
//  final Color backgroundColor;
//
//  String get _text {
//    int hour = properties.startMinuteOfDay ~/ 60;
//    int minute = properties.startMinuteOfDay % 60;
//
//    return "${hour.toString().padLeft(2)}"
//        ":"
//        "${minute.toString().padLeft(2, "0")}";
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      color: backgroundColor ?? Colors.transparent,
//      width: size.width,
//      height: size.height,
//      child: new Center(
//        child: new Text(_text),
//      ),
//    );
//  }
//}

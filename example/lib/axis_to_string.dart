import 'package:flutter/material.dart';

String axisToString(Axis axis) {
  switch (axis) {
    case Axis.horizontal:
      return "Horizontal";
    case Axis.vertical:
      return "Vertical";
    default:
      return "Error";
  }
}

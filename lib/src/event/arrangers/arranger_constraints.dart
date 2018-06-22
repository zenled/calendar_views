import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef double ArrangerConstraintPositionTopCallback(int minuteOfDay);

typedef double ArrangeConstraintHeightCallback(int durationInMinutes);

@immutable
class ArrangerConstraints {
  ArrangerConstraints({
    @required this.areaLeft,
    @required this.areaWidth,
    @required this.positionTop,
    @required this.height,
  })  : assert(areaLeft != null),
        assert(areaWidth != null),
        assert(positionTop != null),
        assert(height != null);

  final double areaLeft;

  final double areaWidth;

  final ArrangerConstraintPositionTopCallback positionTop;

  final ArrangeConstraintHeightCallback height;
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DaySeparationBuilder {
  DaySeparationBuilder({
    @required this.extendOverSeparation,
    @required this.separationWidth,
  })  : assert(extendOverSeparation != null),
        assert(separationWidth != null);

  final bool extendOverSeparation;

  final double separationWidth;

  Widget build() {
    return new Container(
      width: _calculateSeparationWidth(),
    );
  }

  double _calculateSeparationWidth() {
    if (extendOverSeparation) {
      return 0.0;
    } else {
      return separationWidth;
    }
  }
}

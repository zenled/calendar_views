import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';

@immutable
class DaySeparationMaker {
  DaySeparationMaker({
    @required this.positioningAssistant,
    @required this.extendOverDaySeparation,
    @required this.separationNumber,
  });

  final PositioningAssistant positioningAssistant;

  final bool extendOverDaySeparation;

  final int separationNumber;

  Widget make() {
    return new Container(
      width: _calculateSeparationWidth(),
    );
  }

  double _calculateSeparationWidth() {
    if (extendOverDaySeparation) {
      return 0.0;
    } else {
      return positioningAssistant.daySeparationAreaWidth(separationNumber);
    }
  }
}

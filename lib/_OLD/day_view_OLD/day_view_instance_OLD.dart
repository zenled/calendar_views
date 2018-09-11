import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'positioning_assistant/all.dart';
import 'properties/all.dart';

/// Convenience widget that builds [DaysData], [SizeConstraints] and [PositioningAssistantProvider].
class DayViewInstance extends StatefulWidget {
  const DayViewInstance({
    @required this.daysData,
    @required this.child,
  })  : assert(daysData != null),
        assert(child != null);

  /// Returns a [DayViewInstance] made from a list of days.
  factory DayViewInstance.fromListOfDays({
    @required List<DateTime> days,
    @required Widget child,
  }) {
    assert(days != null);

    return new DayViewInstance(
      daysData: new DaysData(days: days),
      child: child,
    );
  }

  /// Returns a [DayViewInstance] made from a single day
  factory DayViewInstance.forASingleDay({
    @required DateTime day,
    @required Widget child,
  }) {
    assert(day != null);

    return new DayViewInstance(
      daysData: new DaysData(days: <DateTime>[day]),
      child: child,
    );
  }

  /// Days events of which should be displayed by child [DayView]s.
  final DaysData daysData;

  final Widget child;

  @override
  _DayViewInstanceState createState() => new _DayViewInstanceState();
}

class _DayViewInstanceState extends State<DayViewInstance> {
  PositioningAssistant _createPositioningAssistant(BuildContext context) {
    return PositioningAssistantGenerator.generateFromContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return new DaysOLD(
      daysData: widget.daysData,
      child: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return new SizeConstraints(
            sizeConstraintsData: new SizeConstraintsData(
              availableWidth: constraints.maxWidth,
            ),
            child: new Builder(builder: (BuildContext context) {
              // A Builder is needed so PositioningAssistantGenerator can access SizeConstraints.

              return new PositioningAssistantProvider(
                positioningAssistant: _createPositioningAssistant(context),
                child: widget.child,
              );
            }),
          );
        },
      ),
    );
  }
}

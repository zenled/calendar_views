import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'positioning_assistant/all.dart';
import 'properties/all.dart';

class DayViewInstance extends StatefulWidget {
  const DayViewInstance({
    @required this.dates,
    @required this.child,
  })  : assert(dates != null),
        assert(child != null);

  factory DayViewInstance.fromAListOfDates({
    @required List<DateTime> dates,
    @required Widget child,
  }) {
    assert(dates != null);

    return new DayViewInstance(
      dates: new Days(dates: dates),
      child: child,
    );
  }

  factory DayViewInstance.forASingleDay({
    @required DateTime day,
    @required Widget child,
  }) {
    assert(day != null);

    return new DayViewInstance(
      dates: new Days(dates: <DateTime>[day]),
      child: child,
    );
  }

  /// Dates of which events are displayed by this DayView.
  final Days dates;

  final Widget child;

  @override
  _DayViewInstanceState createState() => new _DayViewInstanceState();
}

class _DayViewInstanceState extends State<DayViewInstance> {
  PositioningAssistant _createPositioningAssistant(BuildContext context) {
    return PositioningAssistantGenerator
        .of(context)
        .generatePositioningAssistant(context);
  }

  @override
  Widget build(BuildContext context) {
    return new DaysProvider(
      dates: widget.dates,
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return new SizeConstraintsProvider(
          sizeConstraints:
              new SizeConstraints(availableWidth: constraints.maxWidth),
          child: new Builder(builder: (BuildContext context) {
            PositioningAssistant positioningAssistant =
                _createPositioningAssistant(context);

            return new PositioningAssistantProvider(
              positioningAssistant: positioningAssistant,
              child: widget.child,
            );
          }),
        );
      }),
    );
  }
}

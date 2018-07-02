import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'positioning_assistant/all.dart';
import 'properties/all.dart';

class DayViewInstance extends StatefulWidget {
  const DayViewInstance({
    @required this.days,
    @required this.child,
  })  : assert(days != null),
        assert(child != null);

  factory DayViewInstance.fromAListOfDates({
    @required List<DateTime> dates,
    @required Widget child,
  }) {
    assert(dates != null);

    return new DayViewInstance(
      days: new Days(dates: dates),
      child: child,
    );
  }

  factory DayViewInstance.forASingleDay({
    @required DateTime day,
    @required Widget child,
  }) {
    assert(day != null);

    return new DayViewInstance(
      days: new Days(dates: <DateTime>[day]),
      child: child,
    );
  }

  /// Dates of which events are displayed by this DayView.
  final Days days;

  final Widget child;

  @override
  _DayViewInstanceState createState() => new _DayViewInstanceState();
}

class _DayViewInstanceState extends State<DayViewInstance> {
  PositioningAssistant _positioningAssistant;

  PositioningAssistant _createPositioningAssistant(BuildContext context) {
    return PositioningAssistantGenerator
        .of(context)
        .generatePositioningAssistant(context);
  }

  void _handleCreationOfPositioningAssistant({
    @required BuildContext context,
    @required double totalAreaWidth,
  }) {
    // Positioning assistant must be rebuilt if number of days or available width changes.
    if (_positioningAssistant == null ||
        _positioningAssistant.days.numberOfDays != widget.days.numberOfDays ||
        _positioningAssistant.totalAreaWidth != totalAreaWidth) {
      _positioningAssistant = PositioningAssistantGenerator
          .of(context)
          .generatePositioningAssistant(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DaysProvider(
      dates: widget.days,
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return new SizeConstraintsProvider(
          sizeConstraints: new SizeConstraints(
            availableWidth: constraints.maxWidth,
          ),
          child: new Builder(builder: (BuildContext context) {
            _handleCreationOfPositioningAssistant(
              context: context,
              totalAreaWidth: constraints.maxWidth,
            );

            return new PositioningAssistantProvider(
              positioningAssistant: _positioningAssistant,
              child: widget.child,
            );
          }),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Signature for a function that builds a generated support line.
typedef Positioned GeneratedSupportLineBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  double itemWidth,
  int minuteOfDay,
);

/// [ScheduleComponent] for displaying support lines in the [DayViewArea.mainArea] of [DayViewSchedule].
@immutable
class SupportLineComponent implements ScheduleComponent {
  SupportLineComponent._internal({
    @required this.extendOverStartMainArea,
    @required this.extendOverEndMainArea,
    this.supportLines,
    this.minuteOfDayOfFirstSupportLine,
    this.interval,
    this.generatedSupportLineBuilder,
  })  : assert(extendOverStartMainArea != null),
        assert(extendOverEndMainArea != null);

  /// Creates a [ScheduleComponent] that displays the given [supportLines].
  factory SupportLineComponent({
    bool extendOverStartMainArea = true,
    bool extendOverEndMainArea = true,
    @required List<TimeItem> supportLines,
  }) {
    assert(supportLines != null);

    return new SupportLineComponent._internal(
      extendOverStartMainArea: extendOverStartMainArea,
      extendOverEndMainArea: extendOverEndMainArea,
      supportLines: supportLines,
    );
  }

  /// Creates a [ScheduleComponent] that generates and then displays support lines.
  factory SupportLineComponent.intervalGenerated({
    bool extendOverStartMainArea = true,
    bool extendOverEndMainArea = true,
    int minuteOfDayOfFirstSupportLine = 0,
    int interval = 60,
    @required GeneratedSupportLineBuilder generatedSupportLineBuilder,
  }) {
    assert(minuteOfDayOfFirstSupportLine != null &&
        isMinuteOfDayValid(minuteOfDayOfFirstSupportLine));
    assert(interval != null && interval > 0);
    assert(generatedSupportLineBuilder != null);

    return new SupportLineComponent._internal(
      extendOverStartMainArea: extendOverStartMainArea,
      extendOverEndMainArea: extendOverEndMainArea,
      minuteOfDayOfFirstSupportLine: minuteOfDayOfFirstSupportLine,
      interval: interval,
      generatedSupportLineBuilder: generatedSupportLineBuilder,
    );
  }

  /// If true support lines will extend over [DayViewArea.startMainArea].
  final bool extendOverStartMainArea;

  /// If true support lines will extend over [DayViewArea.endMainArea].
  final bool extendOverEndMainArea;

  // provided support lines ----------------------------------------------------
  /// List of support lines to be displayed by this component.
  final List<TimeItem> supportLines;

  // generated support lines ---------------------------------------------------
  /// Minute of day at which the first generated support line will be displayed.
  final int minuteOfDayOfFirstSupportLine;

  /// Number of minutes between generated support lines.
  final int interval;

  /// Function that builds a generated support line.
  final GeneratedSupportLineBuilder generatedSupportLineBuilder;

  bool get _shouldGenerateSupportLines => supportLines == null;

  ItemPosition _makeItemPosition({
    @required SchedulePositioner positioner,
    @required int minuteOfDay,
  }) {
    double left;
    if (extendOverStartMainArea) {
      left = positioner.startMainAreaLeft;
    } else {
      left = positioner.startMainAreaRight;
    }

    return new ItemPosition(
      top: positioner.minuteOfDayFromTop(minuteOfDay),
      left: left,
    );
  }

  double _calculateItemWidth({
    @required SchedulePositioner positioner,
  }) {
    double width = positioner.mainAreaWidth;
    if (!extendOverStartMainArea) {
      width -= positioner.startMainAreaWidth;
    }
    if (!extendOverEndMainArea) {
      width -= positioner.endMainAreaWidth;
    }

    return width;
  }

  @override
  List<Positioned> buildItems(
    BuildContext context,
    DayViewProperties properties,
    SchedulePositioner positioner,
  ) {
    if (_shouldGenerateSupportLines) {
      return _buildGeneratedSupportLines(
        context: context,
        positioner: positioner,
      );
    } else {
      return _buildProvidedSupportLines(
        context: context,
        positioner: positioner,
      );
    }
  }

  List<Positioned> _buildGeneratedSupportLines({
    @required BuildContext context,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (int minuteOfDay = minuteOfDayOfFirstSupportLine;
        minuteOfDay <= maximum_minute_of_day;
        minuteOfDay += interval) {
      ItemPosition itemPosition = _makeItemPosition(
        positioner: positioner,
        minuteOfDay: minuteOfDay,
      );

      double itemWidth = _calculateItemWidth(
        positioner: positioner,
      );

      Positioned item = generatedSupportLineBuilder(
        context,
        itemPosition,
        itemWidth,
        minuteOfDay,
      );

      items.add(item);
    }

    return items;
  }

  List<Positioned> _buildProvidedSupportLines({
    @required BuildContext context,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (TimeItem timeItem in supportLines) {
      ItemPosition itemPosition = _makeItemPosition(
        positioner: positioner,
        minuteOfDay: timeItem.minuteOfDay,
      );

      double itemWidth = _calculateItemWidth(
        positioner: positioner,
      );

      Positioned item = timeItem.builder(
        context,
        itemPosition,
        itemWidth,
      );

      items.add(item);
    }

    return items;
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Signature for a function that builds a generated time indicator.
typedef Positioned GeneratedTimeIndicatorBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  ItemSize itemSize,
  int minuteOfDay,
);

/// [ScheduleComponent] for displaying time indicators in the [DayViewArea.timeIndicationArea] of [DayViewSchedule].
@immutable
class TimeIndicationComponent implements ScheduleComponent {
  /// Creates a [ScheduleComponent] that displays the given [timeIndicators].
  ///
  /// Time indicators are positioned as if they would start at
  /// *[StartDurationItem.startMinuteOfDay] - ([StartDurationItem.duration] / 2)*.
  /// (Center of the item will be at the position of [StartDurationItem.startMinuteOfDay])
  TimeIndicationComponent({
    @required this.timeIndicators,
  })  : assert(timeIndicators != null),
        minuteOfDayOfFirstTimeIndicator = null,
        timeIndicatorDuration = null,
        generatedTimeIndicatorBuilder = null;

  /// Creates a [ScheduleComponent] that generates and then displays time indicators.
  ///
  /// Time indicators are positioned as if they would start
  /// *[timeIndicatorDuration] / 2*
  /// minutes earlier.
  /// (Center of the item will be at the position of minute of day that the item represents)
  TimeIndicationComponent.intervalGenerated({
    this.minuteOfDayOfFirstTimeIndicator = 0,
    this.timeIndicatorDuration = 60,
    @required this.generatedTimeIndicatorBuilder,
  })  : assert(minuteOfDayOfFirstTimeIndicator != null &&
            isMinuteOfDayValid(minuteOfDayOfFirstTimeIndicator)),
        assert(timeIndicatorDuration != null && timeIndicatorDuration > 0),
        assert(generatedTimeIndicatorBuilder != null),
        timeIndicators = null;

  // provided time indicators --------------------------------------------------
  /// List of time indicators to be displayed by this component.
  final List<StartDurationItem> timeIndicators;

  // generated time indicators -------------------------------------------------
  /// Minute of day which the first generated time indicator will represent.
  final int minuteOfDayOfFirstTimeIndicator;

  /// Number of minutes between generated time indicators.
  final int timeIndicatorDuration;

  /// Function that builds a generated time indicator.
  final GeneratedTimeIndicatorBuilder generatedTimeIndicatorBuilder;

  bool get _shouldGenerateTimeIndicators => timeIndicators == null;

  ItemPosition _makeItemPosition({
    @required SchedulePositioner positioner,
    @required int minuteOfDay,
    @required int duration,
  }) {
    int halfDuration = duration ~/ 2;
    int adjustedMinuteOfDay = minuteOfDay - halfDuration;

    return new ItemPosition(
      top: positioner.minuteOfDayFromTop(adjustedMinuteOfDay),
      left: positioner.timeIndicationAreaLeft,
    );
  }

  ItemSize _makeItemSize({
    @required SchedulePositioner positioner,
    @required int duration,
  }) {
    return new ItemSize(
      width: positioner.timeIndicationAreaWidth,
      height: positioner.heightOfDuration(duration),
    );
  }

  @override
  List<Positioned> buildItems(
    BuildContext context,
    DayViewProperties properties,
    SchedulePositioner positioner,
  ) {
    if (_shouldGenerateTimeIndicators) {
      return _buildGeneratedTimeIndicators(
        context: context,
        positioner: positioner,
      );
    } else {
      return _buildProvidedTimeIndicators(
        context: context,
        positioner: positioner,
      );
    }
  }

  List<Positioned> _buildGeneratedTimeIndicators({
    @required BuildContext context,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (int minuteOfDay = minuteOfDayOfFirstTimeIndicator;
        minuteOfDay <= maximum_minute_of_day;
        minuteOfDay += timeIndicatorDuration) {
      ItemPosition itemPosition = _makeItemPosition(
        positioner: positioner,
        minuteOfDay: minuteOfDay,
        duration: timeIndicatorDuration,
      );

      ItemSize itemSize = _makeItemSize(
        positioner: positioner,
        duration: timeIndicatorDuration,
      );

      Positioned item = generatedTimeIndicatorBuilder(
        context,
        itemPosition,
        itemSize,
        minuteOfDay,
      );

      items.add(item);
    }

    return items;
  }

  List<Positioned> _buildProvidedTimeIndicators({
    @required BuildContext context,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (StartDurationItem timeIndicator in timeIndicators) {
      ItemPosition itemPosition = _makeItemPosition(
        positioner: positioner,
        minuteOfDay: timeIndicator.startMinuteOfDay,
        duration: timeIndicator.duration,
      );

      ItemSize itemSize = _makeItemSize(
        positioner: positioner,
        duration: timeIndicator.duration,
      );

      Positioned item = timeIndicator.builder(
        context,
        itemPosition,
        itemSize,
      );

      items.add(item);
    }

    return items;
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

/// Signature for a function that builds an item to be displayed as child of [DayViewSchedule].
typedef Positioned ScheduleComponentItemBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  ItemSize itemSize,
);

/// Base class for an item that can be provided to some implementation of [ScheduleComponent].
@immutable
abstract class ScheduleComponentItem {
  ScheduleComponentItem({
    @required this.builder,
  }) : assert(builder != null);

  /// function that builds this item.
  final ScheduleComponentItemBuilder builder;
}

/// Item with [startMinuteOfDay] and [duration] that can be provided to some implementations of [ScheduleComponent].
class StartDurationItem extends ScheduleComponentItem {
  StartDurationItem({
    @required this.startMinuteOfDay,
    @required this.duration,
    @required ScheduleComponentItemBuilder builder,
  })  : assert(
            startMinuteOfDay != null && isMinuteOfDayValid(startMinuteOfDay)),
        assert(duration != null && duration >= 0),
        super(builder: builder);

  /// Minute of day at which this item starts.
  final int startMinuteOfDay;

  /// Amount of minutes that this item occupies.
  final int duration;
}

/// Item with [minuteOfDay]  that can be provided to some implementations of [ScheduleComponent].
class TimeItem extends ScheduleComponentItem {
  TimeItem({
    @required this.minuteOfDay,
    @required ScheduleComponentItemBuilder builder,
  })  : assert(minuteOfDay != null && isMinuteOfDayValid(minuteOfDay)),
        super(builder: builder);

  /// Minuter of day at which this item happens.
  final int minuteOfDay;
}

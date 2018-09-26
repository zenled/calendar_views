import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Signature for a function that builds a generated day separator.
typedef Positioned GeneratedDaySeparatorBuilder(
  BuildContext context,
  ItemPosition itemPosition,
  ItemSize itemSize,
  int daySeparatorNumber,
);

/// [ScheduleComponent] for displaying day separators in every [DayViewArea.daySeparationArea] of [DayViewSchedule].
@immutable
class DaySeparationComponent implements ScheduleComponent {
  DaySeparationComponent({
    this.extendOverTopExtension = false,
    this.extendOverBottomExtension = false,
    @required this.generatedDaySeparatorBuilder,
  })  : assert(extendOverTopExtension != null),
        assert(extendOverBottomExtension != null),
        assert(generatedDaySeparatorBuilder != null);

  /// If true day separators will extend over top extension of [DayViewSchedule].
  final bool extendOverTopExtension;

  /// If true day separators will extend over bottom extension of [DayViewSchedule].
  final bool extendOverBottomExtension;

  /// Function that builds a generated day separator.
  final GeneratedDaySeparatorBuilder generatedDaySeparatorBuilder;

  ItemPosition _makeItemPosition({
    @required SchedulePositioner positioner,
    @required daySeparatorNumber,
  }) {
    double top;
    if (extendOverTopExtension) {
      top = 0.0;
    } else {
      top = positioner.topExtensionHeight;
    }

    return new ItemPosition(
      top: top,
      left: positioner.daySeparationAreaLeft(daySeparatorNumber),
    );
  }

  ItemSize _makeItemSize({
    @required SchedulePositioner positioner,
    @required int daySeparatorNumber,
  }) {
    double height = positioner.totalHeight;
    if (!extendOverTopExtension) {
      height -= positioner.topExtensionHeight;
    }
    if (!extendOverBottomExtension) {
      height -= positioner.bottomExtensionHeight;
    }

    return new ItemSize(
      width: positioner.daySeparationAreaWidth(daySeparatorNumber),
      height: height,
    );
  }

  @override
  List<Positioned> buildItems(
    BuildContext context,
    DayViewProperties properties,
    SchedulePositioner positioner,
  ) {
    List<Positioned> items = <Positioned>[];

    for (int daySeparatorNumber = 0;
        daySeparatorNumber < properties.numberOfDaySeparations;
        daySeparatorNumber++) {
      ItemPosition itemPosition = _makeItemPosition(
        positioner: positioner,
        daySeparatorNumber: daySeparatorNumber,
      );

      ItemSize itemSize = _makeItemSize(
        positioner: positioner,
        daySeparatorNumber: daySeparatorNumber,
      );

      Positioned item = generatedDaySeparatorBuilder(
        context,
        itemPosition,
        itemSize,
        daySeparatorNumber,
      );

      items.add(item);
    }

    return items;
  }
}

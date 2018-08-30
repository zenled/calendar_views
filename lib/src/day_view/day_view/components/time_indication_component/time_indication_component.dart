import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class TimeIndicationComponent implements DayViewComponent {
  const TimeIndicationComponent({
    @required this.items,
    @required this.itemBuilder,
  })  : assert(items != null),
        assert(itemBuilder != null);

  /// List of TimeIndicators ([TimeIndicatorProperties]) to build when calling [buildItems].
  final List<StartDurationPositionableItem> items;

  /// Function that builds a TimeIndicator.
  final StartDurationPositionableItemBuilder itemBuilder;

  ItemPosition _getItemPosition({
    @required Area area,
    @required StartDurationPositionableItem item,
  }) {
    assert(area != null);
    assert(item != null);

    return new ItemPosition(
      top: area.minuteOfDayFromTop(item.startMinuteOfDay),
      left: area.left,
    );
  }

  ItemSize _getItemSize({
    @required Area area,
    @required StartDurationPositionableItem properties,
  }) {
    assert(area != null);
    assert(properties != null);

    return new ItemSize(
      width: area.size.width,
      height: area.heightOfDuration(properties.duration),
    );
  }

  @override
  List<Positioned> buildItems({
    @required BuildContext context,
    @required Properties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];
    Area area = positioner.getArea(AreaName.timeIndicationArea);

    for (StartDurationPositionableItem item in items) {
      builtItems.add(
        _buildItem(
          context: context,
          itemPosition: _getItemPosition(area: area, item: item),
          itemSize: _getItemSize(area: area, properties: item),
          item: item,
        ),
      );
    }

    return builtItems;
  }

  Positioned _buildItem({
    @required BuildContext context,
    @required ItemPosition itemPosition,
    @required ItemSize itemSize,
    @required StartDurationPositionableItem item,
  }) {
    return itemBuilder(
      context: context,
      position: itemPosition,
      size: itemSize,
      item: item,
    );
  }
}

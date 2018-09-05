import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
class TimeIndicationComponent implements DayViewComponent {
  const TimeIndicationComponent({
    @required this.timeIndicators,
    @required this.timeIndicatorItemBuilder,
  })  : assert(timeIndicators != null),
        assert(timeIndicatorItemBuilder != null);

  final List<ItemWithStartDuration> timeIndicators;
  final ItemWithStartDurationBuilder timeIndicatorItemBuilder;

  ItemPosition _getItemPosition({
    @required Area area,
    @required ItemWithStartDuration item,
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
    @required ItemWithStartDuration properties,
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

    for (ItemWithStartDuration item in timeIndicators) {
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
    @required ItemWithStartDuration item,
  }) {
    return timeIndicatorItemBuilder(
      context: context,
      position: itemPosition,
      size: itemSize,
      item: item,
    );
  }
}

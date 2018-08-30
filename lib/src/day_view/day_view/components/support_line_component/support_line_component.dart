import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class SupportLineComponent implements DayViewComponent {
  SupportLineComponent({
    @required this.items,
    @required this.itemBuilder,
  })  : assert(items != null),
        assert(itemBuilder != null);

  final List<TimePositionableItem> items;
  final TimePositionableItemBuilder itemBuilder;

  ItemPosition _getItemPosition({
    @required Area area,
    @required TimePositionableItem item,
  }) {
    return new ItemPosition(
      top: area.minuteOfDayFromTop(item.minuteOfDay),
      left: area.left,
    );
  }

  double _getItemWidth({
    @required Area area,
  }) {
    return area.size.width;
  }

  @override
  List<Positioned> buildItems({
    @required BuildContext context,
    @required Properties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];
    Area area = positioner.getArea(AreaName.contentArea);

    for (TimePositionableItem item in items) {
      builtItems.add(
        _buildItem(
          context: context,
          itemPosition: _getItemPosition(area: area, item: item),
          itemWidth: _getItemWidth(area: area),
          item: item,
        ),
      );
    }

    return builtItems;
  }

  Positioned _buildItem({
    @required BuildContext context,
    @required ItemPosition itemPosition,
    @required double itemWidth,
    @required TimePositionableItem item,
  }) {
    return itemBuilder(
      context: context,
      position: itemPosition,
      width: itemWidth,
      item: item,
    );
  }
}

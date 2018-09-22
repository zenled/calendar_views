import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
class SupportLineComponent implements DayViewComponent {
  SupportLineComponent({
    @required this.supportLines,
    @required this.supportLineItemBuilder,
  })  : assert(supportLines != null),
        assert(supportLineItemBuilder != null);

  final List<ItemWithTime> supportLines;
  final ItemWithTimeBuilder supportLineItemBuilder;

  ItemPosition _getItemPosition({
    @required Area area,
    @required ItemWithTime item,
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
    @required DayViewProperties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];
    Area area = positioner.getArea(DayViewArea.mainArea);

    for (ItemWithTime item in supportLines) {
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
    @required ItemWithTime item,
  }) {
    return supportLineItemBuilder(
      context: context,
      position: itemPosition,
      width: itemWidth,
      item: item,
    );
  }
}

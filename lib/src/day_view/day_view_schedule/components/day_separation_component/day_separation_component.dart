import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
class DaySeparationComponent implements DayViewComponent {
  DaySeparationComponent({
    @required this.daySeparationItemBuilder,
    this.extendOverTopExtension = true,
    this.extendOverBottomExtension = true,
  })  : assert(daySeparationItemBuilder != null),
        assert(extendOverTopExtension != null),
        assert(extendOverBottomExtension != null);

  final ItemWithGeneratedPositionBuilder daySeparationItemBuilder;

  final bool extendOverTopExtension;
  final bool extendOverBottomExtension;

  @override
  List<Positioned> buildItems({
    @required BuildContext context,
    @required DayViewProperties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];

    for (int daySeparation = 0;
        daySeparation < properties.numberOfDaySeparations;
        daySeparation++) {
      Area area =
          positioner.getNumberedArea(DayViewArea.daySeparationArea, daySeparation);
      double topExtensionHeight = positioner.topExtensionHeight;
      double bottomExtensionHeight = positioner.bottomExtensionHeight;

      ItemPosition position = _makeItemPosition(
        area: area,
        topExtensionHeight: topExtensionHeight,
      );
      ItemSize size = _makeItemSize(
        area: area,
        topExtensionHeight: topExtensionHeight,
        bottomExtensionHeight: bottomExtensionHeight,
      );

      builtItems.add(
        daySeparationItemBuilder(
          context: context,
          position: position,
          size: size,
        ),
      );
    }

    return builtItems;
  }

  ItemPosition _makeItemPosition({
    @required Area area,
    @required double topExtensionHeight,
  }) {
    double top = area.top;
    if (!extendOverTopExtension) {
      top += topExtensionHeight;
    }

    return new ItemPosition(
      top: top,
      left: area.left,
    );
  }

  ItemSize _makeItemSize({
    @required Area area,
    @required double topExtensionHeight,
    @required double bottomExtensionHeight,
  }) {
    double height = area.size.height;
    if (!extendOverTopExtension) {
      height -= topExtensionHeight;
    }
    if (!extendOverBottomExtension) {
      height -= bottomExtensionHeight;
    }

    return new ItemSize(
      width: area.size.width,
      height: height,
    );
  }
}

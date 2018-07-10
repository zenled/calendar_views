import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/day_view/positioning_assistant/all.dart';
import 'package:calendar_views/src/day_view/properties/all.dart';

import 'days_header_item_builder.dart';
import '_one_time_builder.dart';

export 'days_header_item_builder.dart';

/// Widget that builds widgets in the same horizontal position as days of [DayView].
class DaysHeader extends StatefulWidget {
  static const default_VerticalAlignment = CrossAxisAlignment.start;
  static const default_extendOverDaySeparation = true;
  static const default_extendOverEventsAreaStartMargin = true;
  static const default_extendOverEventsAreaEndMargin = true;

  DaysHeader._internal({
    @required this.verticalAlignment,
    @required this.extendOverDaySeparation,
    @required this.extendOverEventsAreaStartMargin,
    @required this.extendOverEventsAreaEndMargin,
    @required this.items,
    @required this.itemBuilder,
  })  : assert(verticalAlignment != null),
        assert(extendOverDaySeparation != null),
        assert(extendOverEventsAreaStartMargin != null),
        assert(extendOverEventsAreaEndMargin != null),
        assert((items != null && itemBuilder == null) ||
            (items == null && itemBuilder != null));

  /// Returns [DaysHeader] with pre-defined items.
  factory DaysHeader({
    CrossAxisAlignment verticalAlignment = default_VerticalAlignment,
    bool extendOverDaySeparation = default_extendOverDaySeparation,
    bool extendOverEventsAreaStartMargin =
        default_extendOverEventsAreaStartMargin,
    bool extendOverEventsAreaEndMargin = default_extendOverEventsAreaEndMargin,
    @required List<Widget> items,
  }) {
    return DaysHeader._internal(
      verticalAlignment: verticalAlignment,
      extendOverDaySeparation: extendOverDaySeparation,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      items: items,
      itemBuilder: null,
    );
  }

  /// Returns [DaysHeader] where each item is build by [itemBuilder].
  factory DaysHeader.builder({
    CrossAxisAlignment verticalAlignment = default_VerticalAlignment,
    bool extendOverDaySeparation = default_extendOverDaySeparation,
    bool extendOverEventsAreaStartMargin =
        default_extendOverEventsAreaStartMargin,
    bool extendOverEventsAreaEndMargin = default_extendOverEventsAreaEndMargin,
    @required DaysHeaderItemBuilder itemBuilder,
  }) {
    return DaysHeader._internal(
      verticalAlignment: verticalAlignment,
      extendOverDaySeparation: extendOverDaySeparation,
      extendOverEventsAreaStartMargin: extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: extendOverEventsAreaEndMargin,
      items: null,
      itemBuilder: itemBuilder,
    );
  }

  /// Vertical alignment of header items in case they are not the same size.
  final CrossAxisAlignment verticalAlignment;

  /// If true items will expand over daySeparation.
  ///
  /// If true each item expend over half of daySeparation before
  /// nd over half of daySeparation after the day it belongs to.
  final bool extendOverDaySeparation;

  /// If true the first item will expand over the events area start margin.
  final bool extendOverEventsAreaStartMargin;

  /// If true the last item will expand over the events area end margin.
  final bool extendOverEventsAreaEndMargin;

  /// List of widgets to be placed inside this widget.
  ///
  /// There must be the same number of items as there are days in provided by [DaysData].
  final List<Widget> items;

  /// Function that builds and item inside this widget.
  final DaysHeaderItemBuilder itemBuilder;

  @override
  _DaysHeaderState createState() => new _DaysHeaderState();
}

class _DaysHeaderState extends State<DaysHeader> {
  PositioningAssistant _getPositioningAssistant() {
    return PositioningAssistantProvider.of(context);
  }

  DaysData _getDaysData() {
    return Days.of(context);
  }

  void _throwArgumentErrorIfInvalidNumberOfItems(DaysData daysData) {
    if (widget.items != null) {
      if (widget.items.length != daysData.numberOfDays) {
        throw new ArgumentError(
          "Number of items must be the same as number of days provided by \"Days\" widget.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PositioningAssistant positioningAssistant = _getPositioningAssistant();
    DaysData days = _getDaysData();

    _throwArgumentErrorIfInvalidNumberOfItems(days);

    OneTimeBuilder oneTimeBuilder = new OneTimeBuilder(
      context: context,
      positioningAssistant: positioningAssistant,
      daysData: days,
      verticalAlignment: widget.verticalAlignment,
      extendOverDaySeparation: widget.extendOverDaySeparation,
      extendOverEventsAreaStartMargin: widget.extendOverEventsAreaStartMargin,
      extendOverEventsAreaEndMargin: widget.extendOverEventsAreaEndMargin,
      items: widget.items,
      itemBuilder: widget.itemBuilder,
    );

    return oneTimeBuilder.build();
  }
}

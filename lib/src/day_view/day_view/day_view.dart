import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class DayView extends StatefulWidget {
  DayView({
    this.heightPerMinute,
    this.topExtensionHeight = 16.0,
    this.bottomExtensionHeight = 16.0,
    @required this.components,
  })  : assert(topExtensionHeight != null),
        assert(bottomExtensionHeight != null),
        assert(components != null);

  final double heightPerMinute;

  final double topExtensionHeight;
  final double bottomExtensionHeight;

  final List<DayViewComponent> components;

  @override
  State createState() => new _DayViewState();
}

class _DayViewState extends State<DayView> {
  Positioner _createPositioner(double availableHeight) {
    return new Positioner(
      horizontalPositioner: DayViewEssentials.of(context).horizontalPositioner,
      heightPerMinute: _calculateHeightPerMinute(availableHeight),
      topExtensionHeight: widget.topExtensionHeight,
      bottomExtensionHeight: widget.bottomExtensionHeight,
    );
  }

  double _calculateHeightPerMinute(double availableHeight) {
    if (widget.heightPerMinute == null) {
      double heightWithoutExtensions = availableHeight -
          widget.topExtensionHeight -
          widget.bottomExtensionHeight;

      int totalNumberOfMinutes =
          DayViewEssentials.of(context).properties.totalNumberOfMinutes;

      return heightWithoutExtensions / totalNumberOfMinutes;
    } else {
      return widget.heightPerMinute;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Properties properties = DayViewEssentials.of(context).properties;
        Positioner positioner = _createPositioner(constraints.maxHeight);

        return new Container(
          width: positioner.availableWidth,
          height: positioner.nonPaddedAreaHeight,
          child: new Stack(
            children: _buildComponentItems(
              context: context,
              properties: properties,
              positioner: positioner,
            ),
          ),
        );
      },
    );
  }

  List<Positioned> _buildComponentItems({
    @required BuildContext context,
    @required Properties properties,
    @required Positioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (DayViewComponent component in widget.components) {
      items.addAll(component.buildItems(
        context: context,
        properties: properties,
        positioner: positioner,
      ));
    }

    return items;
  }
}

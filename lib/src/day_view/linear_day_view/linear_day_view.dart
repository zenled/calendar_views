import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

class LinearDayView extends StatefulWidget {
  LinearDayView({
    @required this.items,
  }) : assert(items != null);

  final List<LinearDayViewItem> items;

  @override
  State createState() => new _LinearDayViewState();
}

class _LinearDayViewState extends State<LinearDayView> {
  DayViewEssentialsState _dayViewEssentials;

  HorizontalPositioner get _horizontalPositioner =>
      _dayViewEssentials.horizontalPositioner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dayViewEssentials = DayViewEssentials.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: _horizontalPositioner.totalAreaWidth,
      child: new Stack(
        children: _buildStackChildren(),
      ),
    );
  }

  List<Positioned> _buildStackChildren() {
    List<Positioned> items = <Positioned>[];

    for (LinearDayViewItem item in widget.items) {
      items.add(
        _buildStackChild(item),
      );
    }

    return items;
  }

  Positioned _buildStackChild(LinearDayViewItem item) {
    if (item is NonNumberedLinearDayViewItem) {
      return _buildNonNumberedItem(item);
    } else if (item is NumberedLinearDayViewItem) {
      return _buildNumberedItem(item);
    } else {
      throw new Exception("Should not happen");
    }
  }

  Positioned _buildNonNumberedItem(NonNumberedLinearDayViewItem item) {
    double left = _horizontalPositioner.getNonNumberedAreaLeft(item.area);
    double width = _horizontalPositioner.getNonNumberedAreaWidth(item.area);
    Widget child = item.itemBuilder(context);

    return new Positioned(
      left: left,
      width: width,
      child: child,
    );
  }

  Positioned _buildNumberedItem(NumberedLinearDayViewItem item) {
    double left =
        _horizontalPositioner.getNumberedAreaLeft(item.area, item.areNumber);
    double width =
        _horizontalPositioner.getNumberedAreaWidth(item.area, item.areNumber);
    Widget child = item.itemBuilder(context);

    return new Positioned(
      left: left,
      width: width,
      child: child,
    );
  }
}

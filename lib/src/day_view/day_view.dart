import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'dimensions_positions/all.dart';
import 'components/all.dart';
import 'day_view_date.dart';

class DayView extends StatelessWidget {
  const DayView({
    @required this.date,
  }) : assert(date != null);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: DayViewPositions.of(context).width,
      height: DayViewPositions.of(context).height,
      child: new DayViewDate(
        date: date,
        child:
            // A builder is required so that components can access DayViewDate
            new Builder(builder: (BuildContext context) {
          return new Stack(
            children: _buildComponents(context),
          );
        }),
      ),
    );
  }

  List<Positioned> _buildComponents(BuildContext context) {
    List<Positioned> itemsWidgets = <Positioned>[];

    List<DayViewComponent> items =
        DayViewComponentsProvider.of(context).components;
    for (DayViewComponent item in items) {
      itemsWidgets.addAll(
        item.buildItems(context),
      );
    }

    return itemsWidgets;
  }
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'dimensions_positions/all.dart';
import 'components/all.dart';
import 'day_view_date.dart';

/// Widget that displays a dayView.
class DayView extends StatelessWidget {
  const DayView({
    @required this.date,
  }) : assert(date != null);

  /// Date which events are displayed by this day view.
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

  /// Builds all components inherited from [DayViewComponentsProvider].
  List<Positioned> _buildComponents(BuildContext context) {
    List<Positioned> itemsWidgets = <Positioned>[];

    List<DayViewComponent> components =
        DayViewComponentsProvider.of(context).components;
    for (DayViewComponent item in components) {
      itemsWidgets.addAll(
        item.buildItems(context),
      );
    }

    return itemsWidgets;
  }
}

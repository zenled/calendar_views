import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

/// Widget for display a day view schedule with the given [components].
class DayViewSchedule extends StatefulWidget {
  DayViewSchedule({
    this.heightPerMinute,
    this.topExtensionHeight = 16.0,
    this.bottomExtensionHeight = 16.0,
    @required this.components,
  })  : assert(heightPerMinute == null || heightPerMinute > 0.0),
        assert(topExtensionHeight != null && topExtensionHeight >= 0.0),
        assert(bottomExtensionHeight != null && bottomExtensionHeight >= 0.0),
        assert(components != null);

  /// Height that a minute inside a [DayViewSchedule] will take.
  ///
  /// If null the [DayViewSchedule] will be as big as possible.
  final double heightPerMinute;

  /// Height of extension above minimum minute of day.
  final double topExtensionHeight;

  /// Height of extension below maximum minute of day.
  final double bottomExtensionHeight;

  /// List of components that will be displayed inside this widget.
  ///
  /// Components are painted in the same order as they are provided.
  final List<ScheduleComponent> components;

  @override
  State createState() => new _DayViewScheduleState();
}

class _DayViewScheduleState extends State<DayViewSchedule> {
  DayViewEssentialsState _dayViewEssentials;

  DayViewProperties get _dayViewProperties => _dayViewEssentials.properties;

  HorizontalPositioner get _horizontalPositioner =>
      _dayViewEssentials.horizontalPositioner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dayViewEssentials = DayViewEssentials.of(context);
    if (_dayViewEssentials == null) {
      _throwNoDayViewEssentialsError();
    }
  }

  void _throwNoDayViewEssentialsError() {
    throw new FlutterError("""
Could not inherit DayViewEssentials.

This widget must be a decendant of DayViewEssentials.
""");
  }

  double _determineHeightPerMinute(double availableHeight) {
    _throwErrorIfCannotDetermineHeightPerMinute(availableHeight);

    if (widget.heightPerMinute != null) {
      return widget.heightPerMinute;
    } else {
      double heightWithoutExtensions = availableHeight -
          widget.topExtensionHeight -
          widget.bottomExtensionHeight;

      int totalNumberOfMinutes = _dayViewProperties.totalNumberOfMinutes;

      return heightWithoutExtensions / totalNumberOfMinutes;
    }
  }

  void _throwErrorIfCannotDetermineHeightPerMinute(double availableHeight) {
    if (widget.heightPerMinute == null && availableHeight.isInfinite) {
      throw new FlutterError("""
Could not determine heightPerMinute.

Eather heightPerMinute must be provider or this widget placed as a child of a widget with constrained height.
""");
    }
  }

  SchedulePositioner _createSchedulePositioner(double heightPerMinute) {
    return new SchedulePositioner(
      horizontalPositioner: _horizontalPositioner,
      heightPerMinute: heightPerMinute,
      topExtensionHeight: widget.topExtensionHeight,
      bottomExtensionHeight: widget.bottomExtensionHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double heightPerMinute =
            _determineHeightPerMinute(constraints.maxHeight);

        SchedulePositioner positioner =
            _createSchedulePositioner(heightPerMinute);

        return new Container(
          width: positioner.totalWidth,
          height: positioner.totalHeight,
          child: new Stack(
            children: _buildComponentItems(
              context: context,
              positioner: positioner,
            ),
          ),
        );
      },
    );
  }

  List<Positioned> _buildComponentItems({
    @required BuildContext context,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> items = <Positioned>[];

    for (ScheduleComponent component in widget.components) {
      List<Positioned> componentItems = component.buildItems(
        context,
        _dayViewProperties,
        positioner,
      );

      items.addAll(componentItems);
    }

    return items;
  }
}

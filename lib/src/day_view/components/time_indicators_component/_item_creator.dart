part of time_indicators_component;

class _ItemCreator {
  _ItemCreator({
    @required this.context,
    @required this.restrictions,
    @required this.positioner,
    @required this.itemBuilder,
  })  : assert(context != null),
        assert(restrictions != null),
        assert(positioner != null),
        assert(itemBuilder != null);

  final BuildContext context;

  final DayViewRestrictions restrictions;

  final DayViewPositioner positioner;

  final TimeIndicatorBuilder itemBuilder;

  bool canItemBeBuilt(int minuteOfDay) {
    return _isItemVisible(minuteOfDay);
  }

  Positioned buildItem(TimeIndicatorProperties itemProperties) {
    return itemBuilder(
      context: context,
      position: _createPosition(
        minuteOfDay: itemProperties.minuteOfDay,
        duration: itemProperties.duration,
      ),
      size: _createSize(duration: itemProperties.duration),
      properties: itemProperties,
    );
  }

  bool _isItemVisible(int minuteOfDay) {
    return minuteOfDay >= restrictions.minimumMinuteOfDay &&
        minuteOfDay <= restrictions.maximumMinuteOfDay;
  }

  Position _createPosition({
    @required int minuteOfDay,
    @required int duration,
  }) {
    return new Position(
      top: positioner.minuteOfDayFromTop(minuteOfDay - (duration ~/ 2)),
      left: positioner.timeIndicationAreaLeft,
    );
  }

  Size _createSize({
    @required int duration,
  }) {
    return new Size(
      positioner.dimensions.timeIndicationAreaWidth,
      positioner.heightOfMinutes(duration),
    );
  }
}

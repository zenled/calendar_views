part of time_indicators_component;

class _ItemCreator {
  _ItemCreator({
    @required this.context,
    @required this.restrictions,
    @required this.positions,
    @required this.itemBuilder,
  })  : assert(context != null),
        assert(restrictions != null),
        assert(positions != null),
        assert(itemBuilder != null);

  final BuildContext context;

  final DayViewRestrictions restrictions;

  final DayViewPositions positions;

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
      top: positions.minuteOfDayFromTop(minuteOfDay - (duration ~/ 2)),
      left: positions.timeIndicationAreaLeft,
    );
  }

  Size _createSize({
    @required int duration,
  }) {
    return new Size(
      positions.dimensions.timeIndicationAreaWidth,
      positions.heightOfMinutes(duration),
    );
  }
}

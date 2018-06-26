part of support_lines_component;

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

  BuildContext context;

  DayViewRestrictions restrictions;

  DayViewPositions positions;

  SupportLineBuilder itemBuilder;

  bool canItemBeBuilt(int minuteOfDay) {
    return _isItemVisible(minuteOfDay);
  }

  Positioned buildItem(SupportLineProperties itemProperties) {
    return itemBuilder(
      context: context,
      position: _createItemPosition(itemProperties.minuteOfDay),
      width: _getItemWidth(),
      properties: itemProperties,
    );
  }

  bool _isItemVisible(int minuteOfDay) {
    return minuteOfDay >= restrictions.minimumMinuteOfDay &&
        minuteOfDay <= restrictions.maximumMinuteOfDay;
  }

  Position _createItemPosition(int minuteOfDay) {
    return new Position(
      top: positions.minuteOfDayFromTop(minuteOfDay),
      left: positions.contentAreaLeft,
    );
  }

  double _getItemWidth() {
    return positions.contentAreaWidth;
  }
}

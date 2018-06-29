part of support_lines_component;

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

  BuildContext context;

  DayViewRestrictions restrictions;

  DayViewPositioner positioner;

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
      top: positioner.minuteOfDayFromTop(minuteOfDay),
      left: positioner.contentAreaLeft,
    );
  }

  double _getItemWidth() {
    return positioner.contentAreaWidth;
  }
}

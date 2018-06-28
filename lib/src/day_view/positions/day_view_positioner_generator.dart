part of day_view_positions;

class DayViewPositionerGenerator extends InheritedWidget {
  DayViewPositionerGenerator({
    @required Widget child,
  }) : super(child: child);

  DayViewPositioner createPositioner(BuildContext context) {
    DayViewRestrictions restrictions = _getRestrictions(context);

    return new DayViewPositioner(
      minimumMinuteOfDay: restrictions.minimumMinuteOfDay,
      maximumMinuteOfDay: restrictions.maximumMinuteOfDay,
      numberOfDays: _getNumberOfDays(context),
      dimensions: _getDimensions(context),
      width: _getWidth(context),
    );
  }

  DayViewRestrictions _getRestrictions(BuildContext context) {
    return DayViewRestrictions.of(context);
  }

  int _getNumberOfDays(BuildContext context) {
    return DayViewDates.of(context).numberOfDates;
  }

  DayViewDimensions _getDimensions(BuildContext context) {
    return DayViewDimensionsProvider.of(context).dimensions;
  }

  double _getWidth(BuildContext context) {
    return DayViewWidth.of(context).width;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static DayViewPositionerGenerator of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewPositionerGenerator);
  }
}

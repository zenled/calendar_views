part of day_view_info;

/// Widget that propagates DayView's dates down the tree.
class DayViewDates extends InheritedWidget {
  const DayViewDates({
    @required this.dates,
    @required Widget child,
  })  : assert(dates != null),
        super(child: child);

  /// List of dates to be displayed in DayView.
  final List<DateTime> dates;

  int get numberOfDates => dates.length;

  @override
  bool updateShouldNotify(DayViewDates oldWidget) {
    return !utils.areListsOfDatesTheSame(oldWidget.dates, dates);
  }

  static DayViewDates of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewDates);
  }
}

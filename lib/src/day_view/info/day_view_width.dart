part of day_view_info;

class DayViewWidth extends InheritedWidget {
  DayViewWidth({
    @required this.width,
    @required Widget child,
  })  : assert(width != null && width >= 0),
        super(child: child);

  final double width;

  @override
  bool updateShouldNotify(DayViewWidth oldWidget) {
    return oldWidget.width != width;
  }

  static DayViewWidth of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewWidth);
  }
}

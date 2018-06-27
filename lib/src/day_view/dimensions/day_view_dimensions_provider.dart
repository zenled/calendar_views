part of day_view_dimensions;

class DayViewDimensionsProvider extends InheritedWidget {
  DayViewDimensionsProvider({
    @required this.dimensions,
    @required Widget child,
  })  : assert(dimensions != null),
        super(child: child);

  final DayViewDimensions dimensions;

  @override
  bool updateShouldNotify(DayViewDimensionsProvider oldWidget) {
    return oldWidget.dimensions != dimensions;
  }

  static DayViewDimensionsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DayViewDimensionsProvider);
  }
}

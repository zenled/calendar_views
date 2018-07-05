part of calendar_events;

/// Function that returns a set of events that happen on some [day].
typedef Set<PositionableEvent> GetEventsOf(DateTime day);

class EventsProvider extends InheritedWidget {
  EventsProvider({
    @required this.getEventsOf,
    @required Widget child,
  })  : assert(getEventsOf != null),
        super(child: child);

  /// Returns a set of events that happen on [day].
  final GetEventsOf getEventsOf;

  @override
  bool updateShouldNotify(EventsProvider oldWidget) {
    return false;
  }

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}

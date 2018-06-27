part of calendar_events;

/// Function that returns a set of events that happen on some [date].
typedef Set<PositionableEvent> EventsGetter({
  @required DateTime date,
});

class EventsProvider extends InheritedWidget {
  EventsProvider({
    @required this.getEventsOf,
    @required Widget child,
  })  : assert(getEventsOf != null),
        super(child: child);

  /// Returns a set of events that happen on [date].
  final EventsGetter getEventsOf;

  @override
  bool updateShouldNotify(EventsProvider oldWidget) {
    return false;
  }

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}

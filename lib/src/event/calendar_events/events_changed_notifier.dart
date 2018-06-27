part of calendar_events;

class EventsChangedNotifier extends InheritedWidget {
  EventsChangedNotifier({
    @required this.attach,
    @required this.detach,
    @required Widget child,
  })  : assert(attach != null),
        assert(detach != null),
        super(child: child);

  /// Attaches [OnEventsChangedListener].
  final OnEventsChangedListenerCallback attach;

  /// Detaches [OnEventsChangedListener].
  final OnEventsChangedListenerCallback detach;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static EventsChangedNotifier of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsChangedNotifier);
  }
}

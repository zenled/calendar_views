part of calendar_events;

/// Function that forces the refresh of events of some [date].
typedef RefreshEventsOfCallback({
  @required DateTime date,
});

class EventsRefresher extends InheritedWidget {
  EventsRefresher({
    @required this.refreshEventsOf,
    @required this.refreshEventsOfAllDates,
    @required Widget child,
  })  : assert(refreshEventsOf != null),
        assert(refreshEventsOfAllDates != null),
        super(child: child);

  /// Forces a refresh of evens that happen on [date]
  final RefreshEventsOfCallback refreshEventsOf;

  /// Forces a refresh of events of all dates of which data has been previously fetched.
  final VoidCallback refreshEventsOfAllDates;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static EventsRefresher of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsRefresher);
  }
}

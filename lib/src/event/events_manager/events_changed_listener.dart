part of events_manager;

typedef void EventsChangedListenerCallback(EventsChangedListener listener);

typedef void OnEventsChangedCallback();

/// Class for listening for changes of events of [date].
class EventsChangedListener {
  EventsChangedListener({
    @required this.date,
    @required this.onEventsChanged,
  })  : assert(date != null),
        assert(onEventsChanged != null);

  /// Listener is listening for change of events of this [date].
  final DateTime date;

  /// Function that fires when the set of events of [date] has changed.
  final OnEventsChangedCallback onEventsChanged;
}

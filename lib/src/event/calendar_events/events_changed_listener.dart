import 'package:meta/meta.dart';

typedef void EventsChangedListenerCallback(EventsChangedListener listener);

typedef void OnEventsChangedCallback();

/// Class for listening for changes of events of [day].
class EventsChangedListener {
  EventsChangedListener({
    @required this.day,
    @required this.onEventsChanged,
  })  : assert(day != null),
        assert(onEventsChanged != null);

  /// Listener is listening for change of events of this [day].
  final DateTime day;

  /// Function that fires when the set of events of [day] has changed.
  final OnEventsChangedCallback onEventsChanged;
}

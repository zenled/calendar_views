import 'package:meta/meta.dart';

/// Signature for a function thar receives an [EventsChangedListener].
typedef void EventsChangedListenerCallback(EventsChangedListener listener);

/// Signature for a function that fires when events change.
typedef void OnEventsChangedCallback();

/// Class for listening when events of [day] change.
class EventsChangedListener {
  EventsChangedListener({
    @required this.day,
    @required this.onEventsChanged,
  })  : assert(day != null),
        assert(onEventsChanged != null);

  /// Listener is listening for change of events of this [day].
  final DateTime day;

  /// Function that fires when events of [day] change.
  final OnEventsChangedCallback onEventsChanged;
}

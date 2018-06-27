part of events_component;

/// Signature for a function that builds a Event.
///
/// Event should be encapsulated inside a [Positioned] widget.
typedef Positioned EventBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required T event,
});

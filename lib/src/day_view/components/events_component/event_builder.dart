part of events_component;

/// Signature for a function that builds a Event.
typedef Positioned EventBuilder<T extends PositionableEvent>({
  @required BuildContext context,
  @required Position position,
  @required Size size,
  @required T event,
});

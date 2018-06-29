part of time_indicators_component;

/// Signature for a function that builds a TimeIndicator.
typedef Positioned TimeIndicatorBuilder({
  @required BuildContext context,
  @required ItemPosition position,
  @required Size size,
  @required TimeIndicatorProperties properties,
});

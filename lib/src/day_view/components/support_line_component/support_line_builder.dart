part of support_lines_component;

/// Signature for a function that builds a SupportLine.
typedef Positioned SupportLineBuilder({
  @required BuildContext context,
  @required Position position,
  @required double width,
  @required SupportLineProperties properties,
});

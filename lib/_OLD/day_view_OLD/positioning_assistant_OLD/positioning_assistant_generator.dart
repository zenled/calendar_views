import 'package:flutter/material.dart';

import 'package:calendar_views/src/day_view/properties/all.dart';

import 'positioning_assistant.dart';

/// Class that can generate a positioning assistant from a given [BuildContext].
class PositioningAssistantGenerator {
  /// Generates a [PositioningAssistant] using the given [context].
  static PositioningAssistant generateFromContext(BuildContext context) {
    DaysData daysData = _getDaysData(context);
    if (daysData == null) {
      _throwErrorIfDataCouldNotBeGet("DaysData", "Days");
    }

    DimensionsData dimensionsData = _getDimensionsData(context);
    if (dimensionsData == null) {
      _throwErrorIfDataCouldNotBeGet("DimensionsData", "Dimenstions");
    }

    RestrictionsData restrictionsData = _getRestrictionsData(context);
    if (restrictionsData == null) {
      _throwErrorIfDataCouldNotBeGet("RestrictionsData", "Restrictions");
    }

    SizeConstraintsData sizeConstraintsData = _getSizeConstraintsData(context);
    if (sizeConstraintsData == null) {
      _throwErrorIfDataCouldNotBeGet("SizeConstraintsData", "SizeConstraints");
    }

    return new PositioningAssistant(
      daysData: daysData,
      dimensionsData: dimensionsData,
      restrictionsData: restrictionsData,
      sizeConstraintsData: sizeConstraintsData,
    );
  }

  static DaysData _getDaysData(BuildContext context) => DaysOLD.of(context);

  static DimensionsData _getDimensionsData(BuildContext context) =>
      Dimensions.of(context);

  static RestrictionsData _getRestrictionsData(BuildContext context) =>
      RestrictionsOLD.of(context);

  static SizeConstraintsData _getSizeConstraintsData(BuildContext context) =>
      SizeConstraints.of(context);

  static _throwErrorIfDataCouldNotBeGet(String dataName, String providerName) {
    throw new ArgumentError(
      "Could not get \"$dataName\" from context. "
          "This probably means that there is no \"$providerName\" widget up the widget tree.",
    );
  }
}

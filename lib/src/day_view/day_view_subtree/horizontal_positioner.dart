import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

@immutable
class HorizontalPositioner {
  HorizontalPositioner({
    @required this.properties,
    @required this.widths,
    @required this.availableWidth,
  });

  HorizontalPositioner.fromHorizontalPositioner(
    HorizontalPositioner horizontalPositioner,
  )   : assert(horizontalPositioner != null),
        properties = horizontalPositioner.properties,
        widths = horizontalPositioner.widths,
        availableWidth = horizontalPositioner.availableWidth;

  final Properties properties;

  final Widths widths;
  final double availableWidth;

  // NonPaddedArea -------------------------------------------------------------

  double get nonPaddedAreaWidth =>
      availableWidth - widths.paddingStart - widths.paddingEnd;

  double get nonPaddedAreaLeft => widths.paddingStart;

  double get nonPaddedAreaRight => nonPaddedAreaLeft + nonPaddedAreaWidth;

  // TimeIndicationArea --------------------------------------------------------

  double get timeIndicationAreaWidth => widths.timeIndicationAreaWidth;

  double get timeIndicationAreaLeft => nonPaddedAreaLeft;

  double get timeIndicationAreaRight =>
      timeIndicationAreaLeft + timeIndicationAreaWidth;

  // SeparationArea ------------------------------------------------------------

  double get separationAreaWidth => widths.separationAreaWidth;

  double get separationAreaLeft => timeIndicationAreaRight;

  double get separationAreaRight => separationAreaLeft + separationAreaWidth;

  // ContentArea ---------------------------------------------------------------

  double get contentAreaWidth => _minimumZero(
        nonPaddedAreaWidth - timeIndicationAreaWidth - separationAreaWidth,
      );

  double get contentAreaLeft => separationAreaRight;

  double get contentAreaRight => contentAreaLeft + contentAreaWidth;

  // EventArea -----------------------------------------------------------------

  double get eventAreaWidth => _minimumZero(
        contentAreaWidth -
            widths.eventAreaStartMargin -
            widths.eventAreaEndMargin,
      );

  double get eventAreaLeft => contentAreaLeft + widths.eventAreaStartMargin;

  double get eventAreaRight => eventAreaLeft + eventAreaWidth;

  // DayArea -------------------------------------------------------------------

  double get dayAreaWidth => _minimumZero(
        (eventAreaWidth -
                (properties.numberOfDaySeparations *
                    widths.daySeparationWidth)) /
            properties.numberOfDays,
      );

  double dayAreaLeft(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    double r = eventAreaLeft;
    r += dayNumber * daySeparationAreaWidth;
    r += dayAreaWidth * dayNumber;
    return r;
  }

  double dayAreaRight(int dayNumber) {
    throwArgumentErrorIfInvalidDayNumber(dayNumber);

    return dayAreaLeft(dayNumber) + dayAreaWidth;
  }

  // DaySeparationArea ---------------------------------------------------------

  double get daySeparationAreaWidth => widths.daySeparationWidth;

  double daySeparationAreaLeft(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dayAreaRight(daySeparationNumber);
  }

  double daySeparationAreaRight(int daySeparationNumber) {
    throwArgumentErrorIfInvalidDaySeparationNumber(daySeparationNumber);

    return dayAreaLeft(daySeparationNumber) + daySeparationAreaWidth;
  }

  // ---------------------------------------------------------------------------

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorizontalPositioner &&
          runtimeType == other.runtimeType &&
          properties == other.properties &&
          widths == other.widths &&
          availableWidth == other.availableWidth;

  @override
  int get hashCode =>
      properties.hashCode ^ widths.hashCode ^ availableWidth.hashCode;

  double _minimumZero(double value) {
    if (value < 0) {
      return 0.0;
    } else {
      return value;
    }
  }

  @protected
  void throwArgumentErrorIfInvalidDayNumber(int dayNumber) {
    if (dayNumber < 0 || dayNumber >= properties.numberOfDays) {
      throw new ArgumentError.value(
        dayNumber,
        "dayNumber",
        "Invalid dayNumber",
      );
    }
  }

  @protected
  void throwArgumentErrorIfInvalidDaySeparationNumber(
    int daySeparationNumber,
  ) {
    if (properties.numberOfDaySeparations == 0) {
      throw new ArgumentError("There are no day separations (only one day)");
    } else {
      if (daySeparationNumber < 0 ||
          daySeparationNumber >= properties.numberOfDaySeparations) {
        throw new ArgumentError.value(
          daySeparationNumber,
          "daySeparationNumber",
          "invalid daySeparationNumber",
        );
      }
    }
  }
}

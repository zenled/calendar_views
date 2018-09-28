import 'package:flutter_test/flutter_test.dart';

import 'package:calendar_views/src/day_view/day_view_essentials/all.dart';

void main() {
  group("HorizontalPositioner test", () {
    DayViewProperties dayViewProperties = new DayViewProperties(
      days: <DateTime>[
        new DateTime(2018, 9, 21),
        new DateTime(2018, 9, 22),
      ],
    );

    DayViewWidths dayViewWidths = new DayViewWidths(
        totalAreaStartPadding: 1.0,
        totalAreaEndPadding: 2.0,
        timeIndicationAreaWidth: 3.0,
        separationAreaWidth: 4.0,
        mainAreaStartPadding: 5.0,
        mainAreaEndPadding: 6.0,
        daySeparationAreaWidth: 7.0);

    double totalWidth = 100.0;

    HorizontalPositioner horizontalPositioner;

    setUp(() {
      horizontalPositioner = new HorizontalPositioner(
        properties: dayViewProperties,
        widths: dayViewWidths,
        totalWidth: totalWidth,
      );
    });

    // totalArea ---------------------------------------------------------------
    group("totalArea", () {
      test(".totalAreaWidth", () {
        expect(
          horizontalPositioner.totalAreaWidth,
          100.0,
        );
      });

      test(".totalAreaLeft", () {
        expect(
          horizontalPositioner.totalAreaLeft,
          0.0,
        );
      });

      test(".totalAreaRight", () {
        expect(
          horizontalPositioner.totalAreaRight,
          100.0,
        );
      });
    });

    // startTotalArea ------------------------------------------------------------
    group("startTotalArea", () {
      test(".startTotalAreaWidth", () {
        expect(
          horizontalPositioner.startTotalAreaWidth,
          1.0,
        );
      });

      test(".startTotalAreaLeft", () {
        expect(
          horizontalPositioner.startTotalAreaLeft,
          0.0,
        );
      });

      test(".startTotalAreaRight", () {
        expect(
          horizontalPositioner.startTotalAreaRight,
          1.0,
        );
      });
    });

    // endTotalArea ------------------------------------------------------------
    group("endTotalArea", () {
      test(".endTotalAreaWidth", () {
        expect(
          horizontalPositioner.endTotalAreaWidth,
          2.0,
        );
      });

      test(".endTotalAreaLeft", () {
        expect(
          horizontalPositioner.endTotalAreaLeft,
          98.0,
        );
      });

      test(".endTotalAreaRight", () {
        expect(
          horizontalPositioner.endTotalAreaRight,
          100.0,
        );
      });
    });

    // contentArea -------------------------------------------------------------
    group("contentArea", () {
      test(".contentAreaWidth", () {
        expect(
          horizontalPositioner.contentAreaWidth,
          97.0,
        );
      });

      test(".contentAreaLeft", () {
        expect(
          horizontalPositioner.contentAreaLeft,
          1.0,
        );
      });

      test(".contentAreaRight", () {
        expect(
          horizontalPositioner.contentAreaRight,
          98.0,
        );
      });
    });

    // timeIndicationArea ------------------------------------------------------
    group("timeIndicationArea", () {
      test(".timeIndicationAreaWidth", () {
        expect(
          horizontalPositioner.timeIndicationAreaWidth,
          3.0,
        );
      });

      test(".timeIndicationAreaLeft", () {
        expect(
          horizontalPositioner.timeIndicationAreaLeft,
          1.0,
        );
      });

      test(".timeIndicationAreaRight", () {
        expect(
          horizontalPositioner.timeIndicationAreaRight,
          4.0,
        );
      });
    });

    // separationArea ----------------------------------------------------------
    group("separationArea", () {
      test(".separationAreaWidth", () {
        expect(
          horizontalPositioner.separationAreaWidth,
          4.0,
        );
      });

      test(".separationAreaLeft", () {
        expect(
          horizontalPositioner.separationAreaLeft,
          4.0,
        );
      });

      test(".separationAreaRight", () {
        expect(
          horizontalPositioner.separationAreaRight,
          8.0,
        );
      });
    });

    // mainArea ----------------------------------------------------------------
    group("mainArea", () {
      test(".mainAreaWidth", () {
        expect(
          horizontalPositioner.mainAreaWidth,
          90.0,
        );
      });

      test(".mainAreaLeft", () {
        expect(
          horizontalPositioner.mainAreaLeft,
          8.0,
        );
      });

      test(".mainAreaRight", () {
        expect(
          horizontalPositioner.mainAreaRight,
          98.0,
        );
      });
    });

    // startMainArea -----------------------------------------------------------
    group("startMainArea", () {
      test(".startMainAreaWidth", () {
        expect(
          horizontalPositioner.startMainAreaWidth,
          5.0,
        );
      });

      test(".startMainAreaLeft", () {
        expect(
          horizontalPositioner.startMainAreaLeft,
          8.0,
        );
      });

      test(".startMainAreaRight", () {
        expect(
          horizontalPositioner.startMainAreaRight,
          13.0,
        );
      });
    });

    // endMainArea -----------------------------------------------------------
    group("endMainArea", () {
      test(".endMainAreaWidth", () {
        expect(
          horizontalPositioner.endMainAreaWidth,
          6.0,
        );
      });

      test(".endMainAreaLeft", () {
        expect(
          horizontalPositioner.endMainAreaLeft,
          92.0,
        );
      });

      test(".endMainAreaRight", () {
        expect(
          horizontalPositioner.endMainAreaRight,
          98.0,
        );
      });
    });

    // eventArea ---------------------------------------------------------------
    group("eventArea", () {
      test(".eventAreaWidth", () {
        expect(
          horizontalPositioner.eventAreaWidth,
          79.0,
        );
      });

      test(".eventAreaLeft", () {
        expect(
          horizontalPositioner.eventAreaLeft,
          13.0,
        );
      });

      test(".eventAreaRight", () {
        expect(
          horizontalPositioner.eventAreaRight,
          92.0,
        );
      });
    });

    // dayArea 0 ---------------------------------------------------------------
    group("dayArea 0", () {
      int dayNumber = 0;

      test(".dayAreaWidth", () {
        expect(
          horizontalPositioner.dayAreaWidth(dayNumber),
          36.0,
        );
      });

      test(".dayAreaLeft", () {
        expect(
          horizontalPositioner.dayAreaLeft(dayNumber),
          13.0,
        );
      });

      test(".dayAreaRight", () {
        expect(
          horizontalPositioner.dayAreaRight(dayNumber),
          49.0,
        );
      });
    });

    // dayArea 1 ---------------------------------------------------------------
    group("dayArea 1", () {
      int dayNumber = 1;

      test(".dayAreaWidth", () {
        expect(
          horizontalPositioner.dayAreaWidth(dayNumber),
          36.0,
        );
      });

      test(".dayAreaLeft", () {
        expect(
          horizontalPositioner.dayAreaLeft(dayNumber),
          56.0,
        );
      });

      test(".dayAreaRight", () {
        expect(
          horizontalPositioner.dayAreaRight(dayNumber),
          92.0,
        );
      });
    });

    // daySeparationArea 0 -----------------------------------------------------
    group("daySeparationArea 0", () {
      int daySeparationNumber = 0;

      test(".daySeparationAreaWidth", () {
        expect(
          horizontalPositioner.daySeparationAreaWidth(daySeparationNumber),
          7.0,
        );
      });

      test(".daySeparationAreaLeft", () {
        expect(
          horizontalPositioner.daySeparationAreaLeft(daySeparationNumber),
          49.0,
        );
      });

      test(".daySeparationAreaRight", () {
        expect(
          horizontalPositioner.daySeparationAreaRight(daySeparationNumber),
          56.0,
        );
      });
    });

    // -------------------------------------------------------------------------
    test("throws argumentError if dayAreaNumber is to big", () {
      expect(
        () => horizontalPositioner.dayAreaWidth(2),
        throwsArgumentError,
      );
    });

    test("throws argumentError if daySeparationAreaNumber is to big", () {
      expect(
        () => horizontalPositioner.daySeparationAreaWidth(1),
        throwsArgumentError,
      );
    });
  });
}

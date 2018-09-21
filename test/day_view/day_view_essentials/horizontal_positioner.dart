import 'package:test/test.dart';

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
      totalAreaStartMargin: 1.0,
      totalAreaEndMargin: 2.0,
      timeIndicationAreaWidth: 3.0,
      separationAreaWidth: 4.0,
    );

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

    //
  });
}

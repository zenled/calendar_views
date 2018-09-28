import 'package:flutter_test/flutter_test.dart';

import 'package:calendar_views/src/month_view/day_of_month.dart';

void main() {
  group("DayOfMonth test", () {
    testIsExtendedBefore();
    testIsExtendedAfter();
  });
}

void testIsExtendedBefore() {
  group(".isExtendedBefore", () {
    test("returns true, if it is extended before", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 8, 31),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedBefore,
        true,
      );
    });

    test("returns false, if it is part of month", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 9, 20),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedBefore,
        false,
      );
    });

    test("returns false, if it is extended after", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 10, 1),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedBefore,
        false,
      );
    });
  });
}

void testIsExtendedAfter() {
  group(".isExtendedAfter", () {
    test("returns true, if it is extended after", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 10, 1),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedAfter,
        true,
      );
    });

    test("returns false, if it is part of month", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 9, 20),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedAfter,
        false,
      );
    });

    test("returns false, if it is extended before", () {
      DayOfMonth dayOfMonth = new DayOfMonth(
        day: new DateTime(2018, 8, 31),
        month: new DateTime(2018, 9, 1),
      );

      expect(
        dayOfMonth.isExtendedAfter,
        false,
      );
    });
  });
}

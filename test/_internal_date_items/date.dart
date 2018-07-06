import 'package:test/test.dart';

import 'package:calendar_views/src/_internal_date_items/date.dart';

void main() {
  group("test Date", () {
    _testFromDateTime();
    _testToday();
    _testToDateTime();
    _testIsBefore();
    _testIsAfter();
    _testDaysBetween();
    _testCopyWith();
    _testAdd();
    _testLowerToFirstWeekday();
  });
}

void _testFromDateTime() {
  group(".fromDateTime", () {
    test("test1", () {
      DateTime dateTime = new DateTime(2018, 1, 1);

      Date date = new Date.fromDateTime(dateTime);
      Date expected = new Date(year: 2018, month: 1, day: 1);

      expect(date, expected);
    });
  });
}

void _testToday() {
  group(".today", () {
    test("test1", () {
      Date date = new Date.today();

      DateTime now = new DateTime.now();
      Date expected = new Date(
        year: now.year,
        month: now.month,
        day: now.day,
      );

      expect(date, expected);
    });
  });
}

void _testToDateTime() {
  group(".toDateTime", () {
    test("test1", () {
      Date date = new Date(year: 2018, month: 1, day: 1);

      DateTime expected = new DateTime(2018, 1, 1);
      expect(date.toDateTime(), expected);
    });
  });
}

void _testIsBefore() {
  group(".isBefore", () {
    test("next day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date nextDay = new Date(year: 2018, month: 1, day: 1);

      expect(date.isBefore(nextDay), true);
    });

    test("two days after", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date nextDay = new Date(year: 2018, month: 1, day: 2);

      expect(date.isBefore(nextDay), true);
    });

    test("same day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date sameDay = new Date(year: 2017, month: 12, day: 31);

      expect(date.isBefore(sameDay), false);
    });

    test("previous day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date sameDay = new Date(year: 2017, month: 12, day: 30);

      expect(date.isBefore(sameDay), false);
    });
  });
}

void _testIsAfter() {
  group(".isAfter", () {
    test("next day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date nextDay = new Date(year: 2018, month: 1, day: 1);

      expect(date.isAfter(nextDay), false);
    });

    test("two days after", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date nextDay = new Date(year: 2018, month: 1, day: 2);

      expect(date.isAfter(nextDay), false);
    });

    test("same day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date sameDay = new Date(year: 2017, month: 12, day: 31);

      expect(date.isAfter(sameDay), false);
    });

    test("previous day", () {
      Date date = new Date(year: 2017, month: 12, day: 31);
      Date sameDay = new Date(year: 2017, month: 12, day: 30);

      expect(date.isAfter(sameDay), true);
    });
  });
}

void _testDaysBetween() {
  group(".daysBetween", () {
    test("same day", () {
      Date date = new Date(year: 2018, month: 1, day: 1);
      Date sameDate = new Date(year: 2018, month: 1, day: 1);

      expect(date.daysBetween(sameDate), 0);
    });

    test("one day after", () {
      Date date = new Date(year: 2018, month: 1, day: 1);
      Date sameDate = new Date(year: 2018, month: 1, day: 2);

      expect(date.daysBetween(sameDate), 1);
    });

    test("one day before", () {
      Date date = new Date(year: 2018, month: 1, day: 1);
      Date sameDate = new Date(year: 2017, month: 12, day: 31);

      expect(date.daysBetween(sameDate), -1);
    });
  });
}

void _testCopyWith() {
  group(".copyWith", () {
    test("year changed", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.copyWith(year: 2016);
      Date expected = new Date(year: 2016, month: 2, day: 3);

      expect(actual, expected);
    });

    test("month changed", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.copyWith(month: 1);
      Date expected = new Date(year: 2018, month: 1, day: 3);

      expect(actual, expected);
    });

    test("day changed", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.copyWith(day: 4);
      Date expected = new Date(year: 2018, month: 2, day: 4);

      expect(actual, expected);
    });

    test("all values changed", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.copyWith(year: 2016, month: 4, day: 2);
      Date expected = new Date(year: 2016, month: 4, day: 2);

      expect(actual, expected);
    });
  });
}

void _testAdd() {
  group(".add", () {
    test("adds nothing", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.add();
      Date expected = new Date(year: 2018, month: 2, day: 3);

      expect(actual, expected);
    });

    test("adds 1 year", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.add(years: 1);
      Date expected = new Date(year: 2019, month: 2, day: 3);

      expect(actual, expected);
    });

    test("adds -1 year", () {
      Date date = new Date(year: 2018, month: 2, day: 3);
      Date actual = date.add(years: -1);
      Date expected = new Date(year: 2017, month: 2, day: 3);

      expect(actual, expected);
    });

    test("adds 1 month, does not go to next year", () {
      Date date = new Date(year: 2018, month: 1, day: 3);
      expect(
        date.add(months: 1),
        new Date(year: 2018, month: 2, day: 3),
      );
    });

    test("adds 1 month, goes to next year", () {
      Date date = new Date(year: 2018, month: 12, day: 13);
      expect(
        date.add(months: 1),
        new Date(year: 2019, month: 1, day: 13),
      );
    });

    test("adds -1 month, does not go to previous year", () {
      Date date = new Date(year: 2018, month: 2, day: 13);
      expect(
        date.add(months: -1),
        new Date(year: 2018, month: 1, day: 13),
      );
    });

    test("adds -1 month, goes to previous year", () {
      Date date = new Date(year: 2018, month: 1, day: 13);
      expect(
        date.add(months: -1),
        new Date(year: 2017, month: 12, day: 13),
      );
    });

    test("adds 10 months, does not go next year", () {
      Date date = new Date(year: 2018, month: 2, day: 14);
      expect(
        date.add(months: 10),
        new Date(year: 2018, month: 12, day: 14),
      );
    });

    test("adds 10 months, goes to next year", () {
      Date date = new Date(year: 2018, month: 9, day: 14);
      expect(
        date.add(months: 10),
        new Date(year: 2019, month: 7, day: 14),
      );
    });

    test("adds -10 months, does not go to previous year", () {
      Date date = new Date(year: 2018, month: 11, day: 15);
      expect(
        date.add(months: -10),
        new Date(year: 2018, month: 1, day: 15),
      );
    });

    test("adds -10 months, goes to previous year", () {
      Date date = new Date(year: 2018, month: 1, day: 15);
      expect(
        date.add(months: -10),
        new Date(year: 2017, month: 3, day: 15),
      );
    });

    test("adds +100 months", () {
      Date date = new Date(year: 2018, month: 3, day: 8);
      expect(
        date.add(months: 100),
        new Date(year: 2026, month: 7, day: 8),
      );
    });

    test("adds -100 months", () {
      Date date = new Date(year: 2018, month: 3, day: 8);
      expect(
        date.add(months: -100),
        new Date(year: 2009, month: 11, day: 8),
      );
    });

    test("adds 1 day, does not change year or month", () {
      Date date = new Date(year: 2020, month: 8, day: 9);
      expect(
        date.add(days: 1),
        new Date(year: 2020, month: 8, day: 10),
      );
    });

    test("adds 1 day, changes month", () {
      Date date = new Date(year: 2020, month: 8, day: 31);
      expect(
        date.add(days: 1),
        new Date(year: 2020, month: 9, day: 1),
      );
    });

    test("adds 1 day, changes year and month", () {
      Date date = new Date(year: 2020, month: 12, day: 31);
      expect(
        date.add(days: 1),
        new Date(year: 2021, month: 1, day: 1),
      );
    });

    test("adds -1 day, does not change year or month", () {
      Date date = new Date(year: 2020, month: 8, day: 9);
      expect(
        date.add(days: -1),
        new Date(year: 2020, month: 8, day: 8),
      );
    });

    test("adds -1 day, changes month", () {
      Date date = new Date(year: 2020, month: 8, day: 1);
      expect(
        date.add(days: -1),
        new Date(year: 2020, month: 7, day: 31),
      );
    });

    test("adds -1 day, changes year and month", () {
      Date date = new Date(year: 2020, month: 1, day: 1);
      expect(
        date.add(days: -1),
        new Date(year: 2019, month: 12, day: 31),
      );
    });

    test("adds 1 year, 1 month, 1 day", () {
      Date date = new Date(year: 2018, month: 6, day: 4);
      expect(
        date.add(years: 1, months: 1, days: 1),
        new Date(year: 2019, month: 7, day: 5),
      );
    });

    test("adds -1 year, -1 month, -1 day", () {
      Date date = new Date(year: 2018, month: 6, day: 4);
      expect(
        date.add(years: -1, months: -1, days: -1),
        new Date(year: 2017, month: 5, day: 3),
      );
    });
  });
}

void _testLowerToFirstWeekday() {
  group(".lowerToFirstWeekday", () {
    test("is same day", () {
      Date date = new Date(year: 2018, month: 7, day: 5);
      int firstWeekday = date.weekday;
      expect(date.lowerToFirstWeekday(firstWeekday), date);
    });

    test("is previous day", () {
      Date date = new Date(year: 2018, month: 7, day: 5);
      int firstWeekday = date.weekday - 1;
      Date expected = date.add(days: -1);
      expect(date.lowerToFirstWeekday(firstWeekday), expected);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';

void main() {
  group("Date", () {
    _testFactoryFromDateTime();
    _testFactoryToday();
    _testToDateTime();
    _testIsBefore();
    _testIsAfter();
    _testDaysBetween();
    _testLowerToWeekday();
    _testCopyWith();
    _testAddDays();
  });
}

void _testFactoryFromDateTime() {
  group("factory .fromDateTime", () {
    test("first day of year", () {
      DateTime dateTime = new DateTime(2018, 1, 1);

      Date actual = new Date.fromDateTime(dateTime);
      Date matcher = new Date(2018, 1, 1);

      expect(actual, matcher);
    });
  });
}

void _testFactoryToday() {
  group("factory .today", () {
    test("test if matches with DateTime.now()", () {
      Date actual = new Date.today();
      DateTime now = new DateTime.now();
      Date matcher = new Date(
        now.year,
        now.month,
        now.day,
      );

      expect(actual, matcher);
    });
  });
}

void _testToDateTime() {
  group(".toDateTime", () {
    test("test1", () {
      Date date = new Date(2018, 1, 1);

      DateTime actual = date.toDateTime();
      DateTime matcher = new DateTime(2018, 1, 1);

      expect(actual, matcher);
    });
  });
}

void _testIsBefore() {
  group(".isBefore", () {
    test("the next day", () {
      Date date = new Date(2017, 12, 31);
      Date nextDay = new Date(2018, 1, 1);

      bool actual = date.isBefore(nextDay);

      expect(actual, true);
    });

    test("the day after next day", () {
      Date date = new Date(2017, 12, 31);
      Date dayAfterNextDay = new Date(2018, 1, 2);

      bool actual = date.isBefore(dayAfterNextDay);

      expect(actual, true);
    });

    test("the same date", () {
      Date date = new Date(2017, 12, 31);

      bool actual = date.isBefore(date);

      expect(actual, false);
    });

    test("the previous day", () {
      Date date = new Date(2017, 12, 31);
      Date previousDay = new Date(2017, 12, 30);

      bool actual = date.isBefore(previousDay);

      expect(actual, false);
    });
  });
}

void _testIsAfter() {
  group(".isAfter", () {
    test("the next day", () {
      Date date = new Date(2017, 12, 31);
      Date nextDay = new Date(2018, 1, 1);

      bool actual = date.isAfter(nextDay);

      expect(actual, false);
    });

    test("the day after next day", () {
      Date date = new Date(2017, 12, 31);
      Date dayAfterNextDay = new Date(2018, 1, 2);

      bool actual = date.isAfter(dayAfterNextDay);

      expect(actual, false);
    });

    test("the same day", () {
      Date date = new Date(2017, 12, 31);

      bool actual = date.isAfter(date);

      expect(actual, false);
    });

    test("the previous day", () {
      Date date = new Date(2017, 12, 31);
      Date previousDay = new Date(2017, 12, 30);

      bool actual = date.isAfter(previousDay);

      expect(actual, true);
    });
  });
}

void _testDaysBetween() {
  group(".daysBetween", () {
    test("this and same day", () {
      Date date = new Date(2018, 1, 1);

      int actual = date.daysBetween(date);

      expect(actual, 0);
    });

    test("this and the next day", () {
      Date date = new Date(2018, 1, 1);
      Date nextDay = new Date(2018, 1, 2);

      int actual = date.daysBetween(nextDay);
      int matcher = 1;

      expect(actual, matcher);
    });

    test("this and previous day", () {
      Date date = new Date(2018, 1, 1);
      Date previousDay = new Date(2017, 12, 31);

      int actual = date.daysBetween(previousDay);
      int matcher = -1;

      expect(actual, matcher);
    });
  });
}

void _testLowerToWeekday() {
  group(".lowerToWeekday", () {
    test("date is already on weekday", () {
      Date date = new Date(2018, 1, 1);
      int weekday = date.weekday;

      Date actual = date.lowerToWeekday(weekday);
      Date matcher = date;

      expect(actual, matcher);
    });

    test("date is one day after weekday", () {
      Date date = new Date(2018, 8, 14);
      int weekday = DateTime.monday;

      Date actual = date.lowerToWeekday(weekday);
      Date matcher = new Date(2018, 8, 13);

      expect(actual, matcher);
    });

    test("date is one day before weekday", () {
      Date date = new Date(2018, 8, 12);
      int weekday = DateTime.monday;

      Date actual = date.lowerToWeekday(weekday);
      Date matcher = new Date(2018, 8, 6);

      expect(actual, matcher);
    });
  });
}

void _testAddDays() {
  group(".addDays", () {
    test("adds 0 days", () {
      Date date = new Date(2018, 2, 3);

      Date actual = date.addDays(0);
      Date matcher = date;

      expect(actual, matcher);
    });

    test("adds 1 day", () {
      Date date = new Date(2018, 8, 14);

      Date actual = date.addDays(1);
      Date matcher = new Date(2018, 8, 15);

      expect(actual, matcher);
    });

    test("adds 1 day, goes to next month", () {
      Date date = new Date(2018, 8, 31);

      Date actual = date.addDays(1);
      Date matcher = new Date(2018, 9, 1);

      expect(actual, matcher);
    });

    test("adds 1 day, goes to next year", () {
      Date date = new Date(2018, 12, 31);

      Date actual = date.addDays(1);
      Date matcher = new Date(2019, 1, 1);

      expect(actual, matcher);
    });

    test("adds -1 day", () {
      Date date = new Date(2018, 8, 14);

      Date actual = date.addDays(-1);
      Date matcher = new Date(2018, 8, 13);

      expect(actual, matcher);
    });

    test("adds -1 day, goes to previous month", () {
      Date date = new Date(2018, 8, 1);

      Date actual = date.addDays(-1);
      Date matcher = new Date(2018, 7, 31);

      expect(actual, matcher);
    });

    test("adds -1 day, goes to previous year", () {
      Date date = new Date(2018, 1, 1);

      Date actual = date.addDays(-1);
      Date matcher = new Date(2017, 12, 31);

      expect(actual, matcher);
    });
  });
}

void _testCopyWith() {
  group(".copyWith", () {
    test("year changed", () {
      Date date = new Date(2018, 2, 3);

      Date actual = date.copyWith(year: 2016);
      Date matcher = new Date(2016, 2, 3);

      expect(actual, matcher);
    });

    test("month changed", () {
      Date date = new Date(2018, 2, 3);

      Date actual = date.copyWith(month: 1);
      Date matcher = new Date(2018, 1, 3);

      expect(actual, matcher);
    });

    test("day changed", () {
      Date date = new Date(2018, 2, 3);

      Date actual = date.copyWith(day: 4);
      Date matcher = new Date(2018, 2, 4);

      expect(actual, matcher);
    });

    test("all values changed", () {
      Date date = new Date(2018, 2, 3);

      Date actual = date.copyWith(year: 2016, month: 4, day: 2);
      Date matcher = new Date(2016, 4, 2);

      expect(actual, matcher);
    });
  });
}

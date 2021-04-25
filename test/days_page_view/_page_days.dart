import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/days_page_view/_page_days.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PageDays test", () {
    testDaysOfPage();
    testPageOfDay();
  });
}

void testDaysOfPage() {
  group(".daysOfPage, daysPerPage is 4", () {
    PageDays pageDays;
    List<Date> actual;
    List<Date> matcher;

    int initialPage = 10;

    setUp(() {
      pageDays = PageDays(
        initialPage: initialPage,
        firstDayOfInitialPage: Date(2018, 9, 17),
        daysPerPage: 4,
      );
    });

    test("returns correct days when given the initialPage", () {
      actual = pageDays.daysOfPage(initialPage);
      matcher = <Date>[
        Date(2018, 9, 17),
        Date(2018, 9, 18),
        Date(2018, 9, 19),
        Date(2018, 9, 20),
      ];

      expect(actual, matcher);
    });

    test("returns correct days when given initialPage+1", () {
      actual = pageDays.daysOfPage(initialPage + 1);
      matcher = <Date>[
        Date(2018, 9, 21),
        Date(2018, 9, 22),
        Date(2018, 9, 23),
        Date(2018, 9, 24),
      ];

      expect(actual, matcher);
    });

    test("returns correct days when given initialPage+2", () {
      actual = pageDays.daysOfPage(initialPage + 2);
      matcher = <Date>[
        Date(2018, 9, 25),
        Date(2018, 9, 26),
        Date(2018, 9, 27),
        Date(2018, 9, 28),
      ];

      expect(actual, matcher);
    });

    test("returns correct days when given initialPage-1", () {
      actual = pageDays.daysOfPage(initialPage - 1);
      matcher = <Date>[
        Date(2018, 9, 13),
        Date(2018, 9, 14),
        Date(2018, 9, 15),
        Date(2018, 9, 16),
      ];

      expect(actual, matcher);
    });

    test("returns correct days when given initialPage-2", () {
      actual = pageDays.daysOfPage(initialPage - 2);
      matcher = <Date>[
        Date(2018, 9, 9),
        Date(2018, 9, 10),
        Date(2018, 9, 11),
        Date(2018, 9, 12),
      ];

      expect(actual, matcher);
    });
  });

  group(".daysOfPage, daysPerPage is 1", () {
    PageDays pageDays;
    List<Date> actual;
    List<Date> matcher;

    int initialPage = 10;

    setUp(() {
      pageDays = PageDays(
        initialPage: initialPage,
        firstDayOfInitialPage: Date(2018, 9, 17),
        daysPerPage: 1,
      );
    });

    test("returns correct day when given the initialPage", () {
      actual = pageDays.daysOfPage(initialPage);
      matcher = <Date>[
        Date(2018, 9, 17),
      ];

      expect(actual, matcher);
    });

    test("returns correct day when given initialPage+1", () {
      actual = pageDays.daysOfPage(initialPage + 1);
      matcher = <Date>[
        Date(2018, 9, 18),
      ];

      expect(actual, matcher);
    });

    test("returns correct day when given initialPage+2", () {
      actual = pageDays.daysOfPage(initialPage + 2);
      matcher = <Date>[
        Date(2018, 9, 19),
      ];

      expect(actual, matcher);
    });

    test("returns correct day when given initialPage-1", () {
      actual = pageDays.daysOfPage(initialPage - 1);
      matcher = <Date>[
        Date(2018, 9, 16),
      ];

      expect(actual, matcher);
    });

    test("returns correct day when given initialPage-2", () {
      actual = pageDays.daysOfPage(initialPage - 2);
      matcher = <Date>[
        Date(2018, 9, 15),
      ];

      expect(actual, matcher);
    });
  });
}

void testPageOfDay() {
  group(".pageOfDay, daysPerPage is 4", () {
    PageDays pageDays;
    int actual;
    int matcher;

    int initialPage = 10;

    setUp(() {
      pageDays = PageDays(
        initialPage: initialPage,
        firstDayOfInitialPage: Date(2018, 9, 17),
        daysPerPage: 4,
      );
    });

    test("returns correct page when given firstDayOfInitialPage", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 17));
      matcher = initialPage;

      expect(actual, matcher);
    });

    test("returns correct page when given the first day of initialPage+1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 21));
      matcher = initialPage + 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the last day of initialPage+1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 24));
      matcher = initialPage + 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the second day of initialPage+2", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 26));
      matcher = initialPage + 2;

      expect(actual, matcher);
    });

    test("returns correct page when given the first day of initialPage-1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 13));
      matcher = initialPage - 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the last day of initialPage-1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 16));
      matcher = initialPage - 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the second day of initialPage-2", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 10));
      matcher = initialPage - 2;

      expect(actual, matcher);
    });
  });

  group(".pageOfDay, daysPerPage is 1", () {
    PageDays pageDays;
    int actual;
    int matcher;

    int initialPage = 10;

    setUp(() {
      pageDays = PageDays(
        initialPage: initialPage,
        firstDayOfInitialPage: Date(2018, 9, 17),
        daysPerPage: 1,
      );
    });

    test("returns correct page when given the firstDayOfInitialPage", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 17));
      matcher = initialPage;

      expect(actual, matcher);
    });

    test("returns correct page when given the day of initialPage+1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 18));
      matcher = initialPage + 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the first day of initialPage+2", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 19));
      matcher = initialPage + 2;

      expect(actual, matcher);
    });

    test("returns correct page when given the first day of initialPage-1", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 16));
      matcher = initialPage - 1;

      expect(actual, matcher);
    });

    test("returns correct page when given the first day of initialPage-2", () {
      actual = pageDays.pageOfDay(Date(2018, 9, 15));
      matcher = initialPage - 2;

      expect(actual, matcher);
    });
  });
}

import 'package:test/test.dart';

import 'package:calendar_views/src/month_page_view/_page_month.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

void main() {
  group("PageMonth test", () {
    testNumberOfPages();
    testMonthOfPage();
    testPageOfMonth();
  });
}

void testNumberOfPages() {
  group(".numberOfPages", () {
    test("returns null when maximumMonth is null", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.numberOfPages, null);
    });

    test("returns 1 when minimumMonth and maximumMonth are the same", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: new Month(2018, 9),
      );

      expect(pageMonth.numberOfPages, 1);
    });

    test("test 1", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 1),
        maximumMonth: new Month(2018, 9),
      );

      expect(pageMonth.numberOfPages, 9);
    });

    test("test2", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 1),
        maximumMonth: new Month(2019, 3),
      );

      expect(pageMonth.numberOfPages, 15);
    });
  });
}

void testMonthOfPage() {
  group(".monthOfPage", () {
    test("returns minimumMonth for page 0", () {
      Month minimumMonth = new Month(2018, 9);

      PageMonth pageMonth = new PageMonth(
        minimumMonth: minimumMonth,
        maximumMonth: null,
      );

      expect(pageMonth.monthOfPage(0), minimumMonth);
    });

    test("returns correct month for page 1", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.monthOfPage(1), new Month(2018, 10));
    });

    test("returns correct month for page 10", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.monthOfPage(10), new Month(2019, 7));
    });
  });
}

void testPageOfMonth() {
  group(".pageOfMonth", () {
    test("returns 0 when given minimumMonth ", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.pageOfMonth(new Month(2018, 9)), 0);
    });

    test("returns 0 when given a month that is before minimumMonth", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.pageOfMonth(new Month(2018, 8)), 0);
    });

    test("returns 1 when given a month that is one month after minimumMonth",
        () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: null,
      );

      expect(pageMonth.pageOfMonth(new Month(2018, 10)), 1);
    });

    test("returns last page when given a month that is after maximumMonth", () {
      PageMonth pageMonth = new PageMonth(
        minimumMonth: new Month(2018, 9),
        maximumMonth: new Month(2018, 11),
      );

      expect(pageMonth.pageOfMonth(new Month(2018, 12)), 2);
    });
  });
}

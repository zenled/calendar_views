import 'package:flutter_test/flutter_test.dart';

import 'package:calendar_views/src/month_page_view/_page_month.dart';
import 'package:calendar_views/src/_internal_date_time/all.dart';

void main() {
  group("PageMonth test", () {
    testMonthOfPage();
    testPageOfMonth();
  });
}

void testMonthOfPage() {
  group(".monthOfPage", () {
    test("returns initial month if page is the same as initialPage", () {
      int initialPage = 10;
      Month initialMonth = new Month(2018, 9);

      PageMonth pageMonth = new PageMonth(
        initialPage: initialPage,
        initialMonth: initialMonth,
      );

      expect(
        pageMonth.monthOfPage(initialPage),
        initialMonth,
      );
    });

    test("returns correct month if page is initialPage+1", () {
      PageMonth pageMonth = new PageMonth(
        initialPage: 10,
        initialMonth: new Month(2018, 9),
      );

      expect(
        pageMonth.monthOfPage(11),
        new Month(2018, 10),
      );
    });

    test("returns correct month if page is initialPage-1", () {
      PageMonth pageMonth = new PageMonth(
        initialPage: 10,
        initialMonth: new Month(2018, 9),
      );

      expect(
        pageMonth.monthOfPage(9),
        new Month(2018, 8),
      );
    });
  });
}

void testPageOfMonth() {
  group(".pageOfMonth", () {
    test("returns initialPage if month is initialMonth", () {
      int initialPage = 10;
      Month initialMonth = new Month(2018, 9);

      PageMonth pageMonth = new PageMonth(
        initialPage: initialPage,
        initialMonth: initialMonth,
      );

      expect(
        pageMonth.pageOfMonth(initialMonth),
        initialPage,
      );
    });

    test("returns correct page is month is 1 month higher than initialMonth",
        () {
      PageMonth pageMonth = new PageMonth(
        initialPage: 10,
        initialMonth: new Month(2018, 9),
      );

      expect(
        pageMonth.pageOfMonth(new Month(2018, 10)),
        11,
      );
    });

    test("returns correct page is month is 1 month lower than initialMonth",
        () {
      PageMonth pageMonth = new PageMonth(
        initialPage: 10,
        initialMonth: new Month(2018, 9),
      );

      expect(
        pageMonth.pageOfMonth(new Month(2018, 8)),
        9,
      );
    });
  });
}

import 'package:test/test.dart';

import 'package:calendar_views/src/_internal_date_items/month.dart';

void main() {
  _testMonth();
}

void _testMonth() {
  group("Month", () {
    test("factory .fromDateTime", () {
      DateTime dateTime = new DateTime(2018, 3, 31);
      expect(new Month.fromDateTime(dateTime), new Month(2018, 3));
    });
    group(".add", () {
      test("add 0", () {
        Month month = new Month(2018, 1);
        expect(month.add(0), month);
      });

      test("add 1, does not go to next year", () {
        Month month = new Month(2018, 1);
        expect(month.add(1), new Month(2018, 2));
      });

      test("add 1, goes to next year", () {
        Month month = new Month(2018, 12);
        expect(month.add(1), new Month(2019, 1));
      });

      test("add -1, does not go to previous year", () {
        Month month = new Month(2018, 2);
        expect(month.add(-1), new Month(2018, 1));
      });

      test("add -1, goes to previous year", () {
        Month month = new Month(2018, 1);
        expect(month.add(-1), new Month(2017, 12));
      });

      test("add 10, does not go next year", () {
        Month month = new Month(2018, 2);
        expect(month.add(10), new Month(2018, 12));
      });

      test("add -10, does not go to previous year", () {
        Month month = new Month(2018, 11);
        expect(month.add(-10), new Month(2018, 1));
      });

      test("add 10, goes to next year", () {
        Month month = new Month(2018, 9);
        expect(month.add(10), new Month(2019, 7));
      });

      test("add -10, goes to previous year", () {
        Month month = new Month(2018, 1);
        expect(month.add(-10), new Month(2017, 3));
      });

      test("add +100", () {
        Month month = new Month(2018, 3);
        expect(month.add(100), new Month(2026, 7));
      });

      test("add -100", () {
        Month month = new Month(2018, 3);
        expect(month.add(-100), new Month(2009, 11));
      });
    });
  });
}

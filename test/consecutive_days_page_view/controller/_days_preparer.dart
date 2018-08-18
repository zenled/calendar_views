import 'package:test/test.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/consecutive_days_page_view/controller/_days_preparer.dart';

void main() {
  group("DaysPreparer", () {
    _testInitialDayPreparation();
    _testMinimumDayPreparation();
    _testMaximumDayPreparation();
  });
}

void _testInitialDayPreparation() {
  group("initialDay preparation", () {
    test("correctly converts DateTime to Date", () {
      DateTime initialDayCandidate = new DateTime.utc(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 1,
        initialDayCandidate: initialDayCandidate,
        minimumDayCandidate: initialDayCandidate.add(new Duration(days: -1)),
        maximumDayCandidate: initialDayCandidate.add(new Duration(days: 1)),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedInitialDay;
      Date matcher = new Date(2018, 8, 18);

      expect(actual, matcher);
    });
  });
}

void _testMinimumDayPreparation() {
  group("minimumDay preparation", () {
    test("correctly converts DateTime to Date", () {
      DateTime minimumDayCandidate = new DateTime.utc(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 1,
        initialDayCandidate: minimumDayCandidate.add(new Duration(days: 1)),
        minimumDayCandidate: minimumDayCandidate,
        maximumDayCandidate: minimumDayCandidate.add(new Duration(days: 2)),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 18);

      expect(actual, matcher);
    });

    test("throws exception if minimumDay is after initialDay", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 1,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 19),
        maximumDayCandidate: new DateTime(2018, 8, 19),
      );

      expect(
        () => daysPreparer.prepare(),
        throwsArgumentError,
      );
    });

    test("moves minimumDay one day backward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 7,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 12),
        maximumDayCandidate: new DateTime(2018, 8, 24),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 11);

      expect(actual, matcher);
    });

    test("moves minimumDay six days backward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 7,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 10),
        maximumDayCandidate: new DateTime(2018, 8, 24),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 4);

      expect(actual, matcher);
    });
  });
}

void _testMaximumDayPreparation() {
  group("maximumDay preparation", () {
    test("correctly converts DateTime to Date", () {
      DateTime maximumDayCandidate = new DateTime.utc(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 1,
        initialDayCandidate: maximumDayCandidate.add(new Duration(days: -1)),
        minimumDayCandidate: maximumDayCandidate.add(new Duration(days: -2)),
        maximumDayCandidate: maximumDayCandidate,
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 18);

      expect(actual, matcher);
    });

    test("throws exception if maximumDay is before initialDay", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 1,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 17),
        maximumDayCandidate: new DateTime(2018, 8, 17),
      );

      expect(
        () => daysPreparer.prepare(),
        throwsArgumentError,
      );
    });

    test("moves maximumDay one day forward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 7,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 11),
        maximumDayCandidate: new DateTime(2018, 8, 23),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 24);

      expect(actual, matcher);
    });

    test("moves maximumDay six days forward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        daysPerPage: 7,
        initialDayCandidate: new DateTime(2018, 8, 18),
        minimumDayCandidate: new DateTime(2018, 8, 11),
        maximumDayCandidate: new DateTime(2018, 8, 25),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 31);

      expect(actual, matcher);
    });
  });
}

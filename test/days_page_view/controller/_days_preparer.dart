import 'package:test/test.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/days_page_view/controller/_days_preparer.dart';

void main() {
  group("DaysPreparer", () {
    _testInitialDayPreparation();
    _testMinimumDayPreparation();
    _testMaximumDayPreparation();
  });
}

void _testInitialDayPreparation() {
  group("initialDay preparation", () {
    test("correctly sets initialDay if initialDayCandidate is null", () {
      Date defaultInitialDay = new Date(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 7,
        defaultInitialDay: defaultInitialDay,
        initialDayCandidate: null,
        minimumDayCandidate: new Date(2018, 8, 18),
        maximumDayCandidate: new Date(2018, 8, 18),
      );
      daysPreparer.prepare();

      Date actual = defaultInitialDay;
      Date matcher = defaultInitialDay;

      expect(actual, matcher);
    });
  });
}

void _testMinimumDayPreparation() {
  group("minimumDay preparation", () {
    test(
        "correctly sets minimumDay if minimumDayCandidate is null, defaultPagesDeltaFromInitialDay is 1",
        () {
      int defaultPagesDeltaFromInitialDay = 1;

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: defaultPagesDeltaFromInitialDay,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: null,
        maximumDayCandidate: new Date(2018, 8, 19),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 11);

      expect(actual, matcher);
    });

    test(
        "correctly sets minimumDay if minimumDayCandidate is null, defaultPagesDeltaFromInitialDay is 2",
        () {
      int defaultPagesDeltaFromInitialDay = 2;

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: defaultPagesDeltaFromInitialDay,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: null,
        maximumDayCandidate: new Date(2018, 8, 19),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 4);

      expect(actual, matcher);
    });

    test(
        "keeps minimumDay on the same day as initialDay, if both candidates are the same",
        () {
      Date date = new Date(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 2,
        daysPerPage: 7,
        defaultInitialDay: date,
        initialDayCandidate: date,
        minimumDayCandidate: date,
        maximumDayCandidate: new Date(2018, 8, 24),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = date;

      expect(actual, matcher);
    });

    test("throws exception when minimumDay is after initialDay", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 1,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 19),
        maximumDayCandidate: new Date(2018, 8, 19),
      );

      expect(
        () => daysPreparer.prepare(),
        throwsArgumentError,
      );
    });

    test("moves minimumDay one day backward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 12),
        maximumDayCandidate: new Date(2018, 8, 24),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMinimumDay;
      Date matcher = new Date(2018, 8, 11);

      expect(actual, matcher);
    });

    test("moves minimumDay six days backward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 10),
        maximumDayCandidate: new Date(2018, 8, 24),
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
    test(
        "correctly sets maximumDay if maximumDayCandidate is null, defaultPagesDeltaFromInitialDay is 1",
        () {
      int defaultPagesDeltaFromInitialDay = 2;

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: defaultPagesDeltaFromInitialDay,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 11),
        maximumDayCandidate: null,
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 9, 7);

      expect(actual, matcher);
    });

    test(
        "correctly sets maximumDay if maximumDayCandidate is null, defaultPagesDeltaFromInitialDay is 2",
        () {
      int defaultPagesDeltaFromInitialDay = 1;

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: defaultPagesDeltaFromInitialDay,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 11),
        maximumDayCandidate: null,
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 31);

      expect(actual, matcher);
    });

    test(
        "if maximumDay is the same as initialDay, it changes it to the last day of week",
        () {
      Date date = new Date(2018, 8, 18);

      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 2,
        daysPerPage: 7,
        defaultInitialDay: date,
        initialDayCandidate: date,
        minimumDayCandidate: new Date(2018, 8, 11),
        maximumDayCandidate: date,
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 24);

      expect(actual, matcher);
    });

    test("throws exception when maximumDay is before initialDay", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 1,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 17),
        maximumDayCandidate: new Date(2018, 8, 17),
      );

      expect(
        () => daysPreparer.prepare(),
        throwsArgumentError,
      );
    });

    test("moves maximumDay one day forward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 11),
        maximumDayCandidate: new Date(2018, 8, 23),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 24);

      expect(actual, matcher);
    });

    test("moves maximumDay six days forward to satisfy daysPerPage", () {
      DaysPreparer daysPreparer = new DaysPreparer(
        defaultPagesDeltaFromInitialDay: 1,
        daysPerPage: 7,
        defaultInitialDay: new Date(2018, 8, 18),
        initialDayCandidate: new Date(2018, 8, 18),
        minimumDayCandidate: new Date(2018, 8, 11),
        maximumDayCandidate: new Date(2018, 8, 25),
      );
      daysPreparer.prepare();

      Date actual = daysPreparer.preparedMaximumDay;
      Date matcher = new Date(2018, 8, 31);

      expect(actual, matcher);
    });
  });
}

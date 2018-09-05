import 'package:test/test.dart';

import 'package:calendar_views/src/days_page_view/controller/days_page_controller.dart';

void main() {
  group("DaysPageController", () {
    _testDefaultFactory();
  });
}

void _testDefaultFactory() {
  group("default factory", () {
    test("throws ArgumentError if daysPerPage is < 0", () {
      expect(
        () => new DaysPageControllerOLD(
              daysPerPage: 0,
              minimumDate: new DateTime(2000),
            ),
        throwsArgumentError,
      );
    });

    test("throws ArgumentError if initialDay is before minimumDay", () {
      expect(
        () => new DaysPageControllerOLD(
            daysPerPage: 1,
            minimumDate: new DateTime(2018, 8, 20),
            initialDay: new DateTime(2018, 8, 19)),
        throwsArgumentError,
      );
    });

    test("throws ArgumentError if maximumDay is before initialDay", () {
      expect(
        () => new DaysPageControllerOLD(
              daysPerPage: 1,
              initialDay: new DateTime(2018, 8, 20),
              minimumDate: new DateTime(2018, 8, 20),
              maximumDate: new DateTime(2018, 8, 19),
            ),
        throwsArgumentError,
      );
    });

    test(
        "if maximumDay is same as initialDay it increases it to the last day of page",
        () {
      DaysPageControllerOLD controller = new DaysPageControllerOLD(
        daysPerPage: 7,
        initialDay: new DateTime(2018, 8, 20),
        minimumDate: new DateTime(2018, 8, 20),
        maximumDate: new DateTime(2018, 8, 20),
      );

      DateTime actual = controller.maximumDate;
      DateTime matcher = new DateTime(2018, 8, 26);

      expect(actual.year, matcher.year);
      expect(actual.month, matcher.month);
      expect(actual.day, matcher.day);
    });

    test("increases maximumDay by 1, to be the last day of page", () {
      DaysPageControllerOLD controller = new DaysPageControllerOLD(
        daysPerPage: 7,
        initialDay: new DateTime(2018, 8, 20),
        minimumDate: new DateTime(2018, 8, 20),
        maximumDate: new DateTime(2018, 9, 8),
      );

      DateTime actual = controller.maximumDate;
      DateTime matcher = new DateTime(2018, 9, 9);

      expect(actual.year, matcher.year);
      expect(actual.month, matcher.month);
      expect(actual.day, matcher.day);
    });

    test("increases maximumDay by 6, to be the last day of page", () {
      DaysPageControllerOLD controller = new DaysPageControllerOLD(
        daysPerPage: 7,
        initialDay: new DateTime(2018, 8, 20),
        minimumDate: new DateTime(2018, 8, 20),
        maximumDate: new DateTime(2018, 9, 3),
      );

      DateTime actual = controller.maximumDate;
      DateTime matcher = new DateTime(2018, 9, 9);

      expect(actual.year, matcher.year);
      expect(actual.month, matcher.month);
      expect(actual.day, matcher.day);
    });
  });
}

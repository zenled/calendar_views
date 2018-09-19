import 'package:test/test.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/month_page_view/_constriants_validator.dart';

void main() {
  group("ConstraintsValidator test", () {
    group(".validateMinumumMonth", () {
      test("throws ArgumentError when minimumMonth is null", () {
        ConstraintsValidator validator = new ConstraintsValidator(
          minimumMonth: null,
          maximumMonth: null,
        );

        expect(
          () => validator.validateMinimumMonth(),
          throwsArgumentError,
        );
      });
    });

    group(".validateMaximumMonth", () {
      test(
          "throws ArgumentError when maximumMonth is before minimumMonth (year is befor, month is same)",
          () {
        ConstraintsValidator validator = new ConstraintsValidator(
          minimumMonth: new Month(2018, 1),
          maximumMonth: new Month(2017, 1),
        );

        expect(
          () => validator.validateMaximumMonth(),
          throwsArgumentError,
        );
      });

      test(
          "throws ArgumentError when maximumMonth is before minimumMonth (year is same, month is before)",
          () {
        ConstraintsValidator validator = new ConstraintsValidator(
          minimumMonth: new Month(2018, 2),
          maximumMonth: new Month(2018, 1),
        );

        expect(
          () => validator.validateMaximumMonth(),
          throwsArgumentError,
        );
      });
    });
  });
}

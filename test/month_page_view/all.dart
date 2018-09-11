import 'package:test/test.dart';

import '_month_constraints_validator.dart' as month_constraints_validator;
import '_page_month.dart' as page_month;

void main() {
  group("month_page_view test", () {
    month_constraints_validator.main();
    page_month.main();
  });
}

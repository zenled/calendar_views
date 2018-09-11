import 'package:test/test.dart';

import 'date.dart' as test_date;
import 'month.dart' as test_month;

void main() {
  group("_internal_date_time", () {
    test_date.main();
    test_month.main();
  });
}

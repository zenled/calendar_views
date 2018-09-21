import 'package:test/test.dart';

import 'date.dart' as date_test;
import 'month.dart' as month_test;

void main() {
  group("_internal_date_time test", () {
    date_test.main();
    month_test.main();
  });
}

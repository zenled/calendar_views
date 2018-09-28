import 'package:flutter_test/flutter_test.dart';

import 'date.dart' as date;
import 'month.dart' as month;

void main() {
  group("_internal_date_time test", () {
    date.main();
    month.main();
  });
}

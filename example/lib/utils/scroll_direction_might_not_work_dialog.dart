import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'show_alert_dialog.dart';

void showScrollDirectionChangeMightNotWorkDialog({
  @required BuildContext context,
}) {
  assert(context != null);

  showAlertDialog(
    context: context,
    title: "This feature might not work",
    message: """
MothPageView internally uses a PageView.

Due to a bug in PageView, changing scrollDirection during runtime might not work correctly.

https://github.com/flutter/flutter/issues/16481
    """,
  );
}

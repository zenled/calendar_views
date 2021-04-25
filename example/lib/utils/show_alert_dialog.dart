import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void showAlertDialog({
  @required BuildContext context,
  String title = "Alert",
  @required String message,
}) {
  assert(title != null);
  assert(message != null);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

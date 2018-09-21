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
    builder: (context) => new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new Text(message),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
  );
}

import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,
  String title = "Alert",
  required String message,
}) {

  showDialog(
    context: context,
    builder: (context) => new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new Text(message),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
  );
}

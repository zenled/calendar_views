import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MonthPickerDialog extends StatefulWidget {
  MonthPickerDialog({
    @required this.initialMonth,
    @required this.onConfirm,
  })  : assert(initialMonth != null),
        assert(onConfirm != null);

  final DateTime initialMonth;

  final ValueChanged<DateTime> onConfirm;

  @override
  State createState() => new _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  int _year;
  int _month;

  List<int> _years = <int>[];
  List<int> _months = <int>[];

  @override
  void initState() {
    super.initState();

    _year = widget.initialMonth.year;
    _month = widget.initialMonth.month;

    for (int i = 2000; i <= 2025; i++) {
      _years.add(i);
    }

    for (int i = 1; i <= 12; i++) {
      _months.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Month Picker"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Year"),
            trailing: _buildYearDropdownButton(),
          ),
          new ListTile(
            title: new Text("Month"),
            trailing: _buildMonthDropdownButton(),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () {
            DateTime month = new DateTime(_year, _month);
            widget.onConfirm(month);
          },
        )
      ],
    );
  }

  Widget _buildYearDropdownButton() {
    return new DropdownButton<int>(
      value: _year,
      items: _years
          .map(
            (year) => new DropdownMenuItem<int>(
                  value: year,
                  child: new Text("$year"),
                ),
          )
          .toList(),
      onChanged: (year) {
        setState(() {
          _year = year;
        });
      },
    );
  }

  Widget _buildMonthDropdownButton() {
    return new DropdownButton<int>(
      value: _month,
      items: _months
          .map(
            (month) => new DropdownMenuItem<int>(
                  value: month,
                  child: new Text("$month"),
                ),
          )
          .toList(),
      onChanged: (month) {
        setState(() {
          _month = month;
        });
      },
    );
  }
}

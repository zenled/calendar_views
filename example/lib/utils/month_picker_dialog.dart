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
  State createState() => _MonthPickerDialogState();
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
    return AlertDialog(
      title: Text("Month Picker"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("Year"),
            trailing: _buildYearDropdownButton(),
          ),
          ListTile(
            title: Text("Month"),
            trailing: _buildMonthDropdownButton(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            DateTime month = DateTime(_year, _month);
            widget.onConfirm(month);
          },
        )
      ],
    );
  }

  Widget _buildYearDropdownButton() {
    return DropdownButton<int>(
      value: _year,
      items: _years
          .map(
            (year) => DropdownMenuItem<int>(
              value: year,
              child: Text("$year"),
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
    return DropdownButton<int>(
      value: _month,
      items: _months
          .map(
            (month) => DropdownMenuItem<int>(
              value: month,
              child: Text("$month"),
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

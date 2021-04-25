import 'package:flutter/material.dart';

import 'weekday_to_string.dart';

class WeekdayDropDownButton extends StatelessWidget {
  WeekdayDropDownButton({
    required this.value,
    required this.onChanged,
  });

  final int value;

  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      items: <int>[
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday,
        DateTime.friday,
        DateTime.saturday,
        DateTime.sunday,
      ]
          .map(
            (weekday) => DropdownMenuItem<int>(
              value: weekday,
              child: Text(weekdayToString(weekday)),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

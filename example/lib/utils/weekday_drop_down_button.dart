import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'weekday_to_string.dart';

class WeekdayDropDownButton extends StatelessWidget {
  WeekdayDropDownButton({
    @required this.value,
    @required this.onChanged,
  })  : assert(value != null),
        assert(onChanged != null);

  final int value;

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return new DropdownButton<int>(
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
            (weekday) => new DropdownMenuItem<int>(
                  value: weekday,
                  child: new Text(weekdayToString(weekday)),
                ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

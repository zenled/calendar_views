import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

String weekdayToName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Monday";
    case DateTime.tuesday:
      return "Tuesday";
    case DateTime.wednesday:
      return "Wednesday";
    case DateTime.thursday:
      return "Thursday";
    case DateTime.friday:
      return "Friday";
    case DateTime.saturday:
      return "Saturday";
    case DateTime.sunday:
      return "Sunday";
    default:
      return "Error";
  }
}

String weekdayToAbbreviatedName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Mon";
    case DateTime.tuesday:
      return "Tue";
    case DateTime.wednesday:
      return "Wed";
    case DateTime.thursday:
      return "Thu";
    case DateTime.friday:
      return "Fri";
    case DateTime.saturday:
      return "Sat";
    case DateTime.sunday:
      return "Sun";
    default:
      return "Err";
  }
}


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
                  child: new Text(weekdayToName(weekday)),
                ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

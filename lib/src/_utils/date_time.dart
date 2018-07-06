/// Minimum allowed minute of day (inclusive).
const int minimum_minute_of_day = 0;

/// Maximum allowed minute of day (inclusive).
const int maximum_minute_of_day = 24 * 60;

bool isValidMinuteOfDay(int minuteOfDay) {
  return (minuteOfDay >= minimum_minute_of_day &&
      minuteOfDay <= maximum_minute_of_day);
}

/// Returns true if date portions of [date1] and [date2] are the same.
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

bool isSameYearAndMonth(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month;
}

/// Returns true if all dates in [list1] and [list2] are the same (both lists must have same length).
bool areListsOfDatesTheSame(List<DateTime> list1, List<DateTime> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (!isSameDate(list1[i], list2[i])) {
      return false;
    }
  }
  return true;
}

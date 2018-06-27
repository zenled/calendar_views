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

/// Returns true if date portion (year, month, day) of [date1] and [date2] are the same.
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

/// Returns true if year and month of [date1] and [date2] are the same.
bool isSameYearAndMonth(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month;
}

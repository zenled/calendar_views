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

/// Returns true is [list1] and [list2] contain the same dates (year, month, day).
///
/// If [list1], [list2] or both contain a null value, false is returned.
bool areListsOfDatesTheSame(List<DateTime> list1, List<DateTime> list2) {
  if (list1.length != list2.length) {
    return false;
  } else {
    for (int i = 0; i < list1.length; i++) {
      DateTime date1 = list1[i];
      DateTime date2 = list2[i];

      if (date1 == null || date2 == null || !isSameDate(date1, date2)) {
        return false;
      }
    }
    return true;
  }
}

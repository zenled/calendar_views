/// Returns a [DateTime] with year, month and day the same as [dateTime] and other properties set to default.
DateTime stripDateInformation(DateTime dateTime) {
  int year = dateTime.year;
  int month = dateTime.month;
  int day = dateTime.day;

  if (dateTime.isUtc) {
    return DateTime.utc(year, month, day);
  } else {
    return DateTime(year, month, day);
  }
}

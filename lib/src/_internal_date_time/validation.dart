// Minute of day ---------------------------------------------------------------

/// Minimum allowed minute of day (inclusive).
const int minimum_minute_of_day = 0;

/// Maximum allowed minute of day (inclusive).
const int maximum_minute_of_day = 24 * 60;

/// Returns true if [minuteOfDay] is valid.
bool isMinuteOfDayValid(int minuteOfDay) {
  return minuteOfDay >= minimum_minute_of_day &&
      minuteOfDay <= maximum_minute_of_day;
}

// Weekday ---------------------------------------------------------------------

/// Minimum allowed weekday (inclusive).
int minimumWeekday = DateTime.monday;

/// Maximum allowed weekday (inclusive).
int maximumWeekday = DateTime.sunday;

/// Returns true if [weekday] is valid.
bool isWeekdayValid(int weekday) {
  return weekday >= minimumWeekday && weekday <= maximumWeekday;
}

// Month -----------------------------------------------------------------------

/// Minimum allowed month (inclusive).
int minimumMonth = DateTime.january;

/// Maximum allowed month (inclusive).
int maximumMonth = DateTime.monthsPerYear;

/// Returns true if [month] is valid.
bool isMonthValid(int month) {
  return month >= minimumMonth && month <= maximumMonth;
}

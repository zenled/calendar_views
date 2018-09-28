// Minute of day ---------------------------------------------------------------

/// Minimum allowed minute of day (inclusive).
const minimum_minute_of_day = 0;

/// Maximum allowed minute of day (inclusive).
const maximum_minute_of_day = 24 * 60;

/// Returns true if [minuteOfDay] is valid.
bool isMinuteOfDayValid(int minuteOfDay) {
  return minuteOfDay >= minimum_minute_of_day &&
      minuteOfDay <= maximum_minute_of_day;
}

// Weekday ---------------------------------------------------------------------

/// Minimum allowed weekday (inclusive).
const minimum_weekday = DateTime.monday;

/// Maximum allowed weekday (inclusive).
const maximum_weekday = DateTime.sunday;

/// Returns true if [weekday] is valid.
bool isWeekdayValid(int weekday) {
  return weekday >= minimum_weekday && weekday <= maximum_weekday;
}

// Month -----------------------------------------------------------------------

/// Minimum allowed month (inclusive).
const minimum_month = DateTime.january;

/// Maximum allowed month (inclusive).
const maximum_month = DateTime.monthsPerYear;

/// Returns true if [month] is valid.
bool isMonthValid(int month) {
  return month >= minimum_month && month <= maximum_month;
}

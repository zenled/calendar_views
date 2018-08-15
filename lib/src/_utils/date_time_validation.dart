// Minute of day ---------------------------------------------------------------

/// Minimum minute of day (inclusive).
const int minimum_minute_of_day = 0;

/// Maximum minute of day (inclusive).
const int maximum_minute_of_day = 24 * 60;

/// Returns true if [minuteOfDay] is valid.
bool isMinuteOfDayValid(int minuteOfDay) {
  return (minuteOfDay >= minimum_minute_of_day &&
      minuteOfDay <= maximum_minute_of_day);
}

// Weekday ---------------------------------------------------------------------

/// Minimum weekday (inclusive).
int minimumWeekday = DateTime.monday;

/// Maximum weekday (inclusive).
int maximumWeekday = DateTime.sunday;

/// Returns true if [weekday] is valid.
bool isWeekdayValid(int weekday) {
  return (weekday >= minimumWeekday && weekday <= maximumWeekday);
}

// Month -----------------------------------------------------------------------

/// Minimum month (inclusive).
int minimumMonth = DateTime.january;

/// Maximum month (inclusive).
int maximumMonth = DateTime.monthsPerYear;

/// Returns true if [month] is valid.
bool isMonthValid(int month) {
  return month >= minimumMonth && month <= maximumMonth;
}

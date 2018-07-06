int minimumWeekday = DateTime.monday;

int maximumWeekday = DateTime.sunday;

bool isValidWeekday(int weekday) {
  return (weekday >= minimumWeekday && weekday <= maximumWeekday);
}

part of week_pager;

class WeekPagerController {
  static const _default_weeksDelta_from_initialWeek = 1000;

  WeekPagerController.raw({
    @required DateTime initialWeek,
    @required DateTime minimumWeek,
    @required DateTime maximumWeek,
    @required this.firstWeekday,
  })  : assert(utils.isValidWeekday(firstWeekday)),
        // converts dateTime to week
        _initialWeek = _dateTimeToWeek(firstWeekday, initialWeek),
        _minimumWeek = _dateTimeToWeek(firstWeekday, minimumWeek),
        _maximumWeek = _dateTimeToWeek(firstWeekday, maximumWeek) {
    // validates _minimumWeek
    if (!(_minimumWeek.isBefore(_initialWeek) ||
        _minimumWeek == _initialWeek)) {
      throw new ArgumentError(
        "MinimumWeek should be before or same week as initialWeek.",
      );
    }
    // validates _maximumWeek
    if (!(_maximumWeek.isAfter(_initialWeek) || _maximumWeek == _initialWeek)) {
      throw new ArgumentError(
        "MaximumWeek should be afrer or same week as initialWeek",
      );
    }

    // sets other properties
    _initialPage = _weeksBetween(_minimumWeek, _initialWeek);
    _numberOfPages = _weeksBetween(_minimumWeek, _maximumWeek) + 1;
  }

  final Date _minimumWeek;

  final Date _maximumWeek;

  final Date _initialWeek;

  final int firstWeekday;

  int _initialPage;

  int _numberOfPages;

  int get initialPage => _initialPage;

  int get numberOfPages => _numberOfPages;

  _PagerPosition _pagerPosition;

  int pageOf(DateTime week) {
    Date w = _dateTimeToWeek(firstWeekday, week);

    if (w.isBefore(_minimumWeek)) {
      return 0;
    }
    if (w.isAfter(_maximumWeek)) {
      return numberOfPages - 1;
    }
    return _weeksBetween(_minimumWeek, w);
  }

  List<DateTime> daysOf(int page) {
    int deltaFromInitialPage = page - initialPage;

    Date desiredWeek = _initialWeek.add(days: deltaFromInitialPage * 7);
    return desiredWeek
        .daysOfWeek(firstWeekday)
        .map(
          (date) => date.toDateTime(),
        )
        .toList();
  }

  List<DateTime> get displayedDays {
    if (_pagerPosition == null) {
      return null;
    } else {
      return daysOf(_pagerPosition.getDisplayedPage());
    }
  }

  void attach(_PagerPosition pagerPosition) {
    _pagerPosition = pagerPosition;
  }

  void detach() {
    _pagerPosition = null;
  }

  void jumpTo(DateTime week) {
    if (_pagerPosition == null) {
      print("Error: no WeekPager attached");
      return;
    }

    _pagerPosition.jumpToPage(
      pageOf(week),
    );
  }

  void animateTo(
    DateTime week, {
    @required Duration duration,
    @required Curve curve,
  }) {
    if (_pagerPosition == null) {
      print("Error: no WeekPager attached");
      return;
    }

    _pagerPosition.animateToPage(
      pageOf(week),
      duration: duration,
      curve: curve,
    );
  }

  static Date _dateTimeToWeek(int firstWeekday, DateTime dateTime) {
    return Date.fromDateTime(dateTime).lowerToFirstWeekday(firstWeekday);
  }

  static int _weeksBetween(Date week1, Date week2) {
    int daysBetween = week1.daysBetween(week2);
    return daysBetween ~/ DateTime.daysPerWeek;
  }
}

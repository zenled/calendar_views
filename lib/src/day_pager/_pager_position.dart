part of day_pager;

typedef void _JumpToPage(int page);

typedef void _AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [DayPager] and [DayPagerController].
@immutable
class _PagerPosition {
  _PagerPosition({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.getDisplayedPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(getDisplayedPage != null);

  /// Tells [DayPager] to jump to a specified page.
  final _JumpToPage jumpToPage;

  /// Tells [DayPager] to animate to a specified page.
  final _AnimateToPage animateToPage;

  /// Requests the current displayed page index from the [DayPager].
  final ValueGetter<int> getDisplayedPage;
}

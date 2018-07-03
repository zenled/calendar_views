part of week_pager;

typedef void _JumpToPage(int page);

typedef void _AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [WeekPager] and [WeekPagerController].
@immutable
class _PagerPosition {
  _PagerPosition({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.getDisplayedPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(getDisplayedPage != null);

  /// Tells [WeekPager] to jump to a specified page.
  final _JumpToPage jumpToPage;

  /// Tells [WeekPager] to animate to a specified page.
  final _AnimateToPage animateToPage;

  /// Requests the current displayed page index from the [WeekPager].
  final ValueGetter<int> getDisplayedPage;
}

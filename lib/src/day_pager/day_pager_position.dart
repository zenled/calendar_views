import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef void JumpToPage(int page);

typedef void AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [DayPager] and [DayPagerController].
@immutable
class DayPagerPosition {
  DayPagerPosition({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.getDisplayedPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(getDisplayedPage != null);

  /// Tells [DayPager] to jump to a specified page.
  final JumpToPage jumpToPage;

  /// Tells [DayPager] to animate to a specified page.
  final AnimateToPage animateToPage;

  /// Requests the current displayed page index from the [DayPager].
  final ValueGetter<int> getDisplayedPage;
}

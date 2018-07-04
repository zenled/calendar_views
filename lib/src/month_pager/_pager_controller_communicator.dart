import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef void JumpToPage(int page);

typedef void AnimateToPage(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Communicator between [MonthPager] and [MonthPagerController].
@immutable
class PagerControllerCommunicator {
  PagerControllerCommunicator({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.getDisplayedPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(getDisplayedPage != null);

  /// Tells [WeekPager] to jump to a specified page.
  final JumpToPage jumpToPage;

  /// Tells [WeekPager] to animate to a specified page.
  final AnimateToPage animateToPage;

  /// Requests the current displayed page index from the [WeekPager].
  final ValueGetter<int> getDisplayedPage;
}

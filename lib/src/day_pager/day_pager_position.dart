import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef void JumpToPageCallback(int page);

typedef void AnimateToPageCallback(
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
  })  : assert(jumpToPage != null),
        assert(animateToPage != null);

  /// Tells [SmallCalendarPager] to jump to a specified page.
  final JumpToPageCallback jumpToPage;

  /// Tells [SmallCalendarPager] to animate to a specified page.
  final AnimateToPageCallback animateToPage;
}

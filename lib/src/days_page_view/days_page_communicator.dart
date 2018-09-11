import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

typedef void JumpToDayCallback(
  DateTime day,
);

typedef Future<Null> AnimateToDayCallback(
  DateTime day, {
  @required Duration duration,
  @required Curve curve,
});

typedef void JumpToPageCallback(
  int page,
);

typedef Future<Null> AnimateToPageCallback(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

@immutable
class DaysPageCommunicator {
  DaysPageCommunicator({
    @required this.displayedDays,
    @required this.jumpToDay,
    @required this.animateToDay,
    @required this.jumpToPage,
    @required this.animateToPage,
  })  : assert(displayedDays != null),
        assert(jumpToDay != null),
        assert(animateToDay != null),
        assert(jumpToPage != null),
        assert(animateToPage != null);

  final ValueGetter<List<DateTime>> displayedDays;

  final JumpToDayCallback jumpToDay;
  final AnimateToDayCallback animateToDay;

  final JumpToPageCallback jumpToPage;
  final AnimateToPageCallback animateToPage;
}

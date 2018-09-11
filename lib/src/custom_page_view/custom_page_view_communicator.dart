import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef void JumpToPageCallback(
  int page,
);

typedef Future<Null> AnimateToPageCallback(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

@immutable
abstract class CustomPageViewCommunicator {
  CustomPageViewCommunicator({
    @required this.currentPage,
    @required this.jumpToPage,
    @required this.animateToPage,
  })  : assert(currentPage != null),
        assert(jumpToPage != null),
        assert(animateToPage != null);

  final ValueGetter<int> currentPage;

  final JumpToPageCallback jumpToPage;
  final AnimateToPageCallback animateToPage;
}

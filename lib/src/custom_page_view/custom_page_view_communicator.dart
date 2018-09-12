import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'custom_page_view.dart';
import 'custom_page_view_controller.dart';

/// Signature for a function that tells [CustomPageView] to jump to specific page.
typedef void JumpToPageCallback(
  int page,
);

/// Signature for a function that tells [CustomPageView] to animate to specific page.
typedef Future<Null> AnimateToPageCallback(
  int page, {
  @required Duration duration,
  @required Curve curve,
});

/// Base class for a communicator between [CustomPageView] and [CustomPageViewController].
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

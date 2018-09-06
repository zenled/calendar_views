import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'custom_page_view_communicator.dart';

abstract class CustomPageViewController {
  const CustomPageViewController();

  CustomPageViewCommunicator get _attachedItem;

  bool get isItemAttached => _attachedItem != null;

  int get currentPage {
    throwExceptionIfNoItemAttached();

    return _attachedItem.currentPage();
  }

  void jumpToPage(int page) {
    throwExceptionIfNoItemAttached();

    _attachedItem.jumpToPage(page);
  }

  Future<Null> animateToPage(
    int page, {
    @required Duration duration,
    @required Curve curve,
  }) {
    throwExceptionIfNoItemAttached();

    return _attachedItem.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  @protected
  void throwExceptionIfNoItemAttached() {
    if (!isItemAttached) {
      throw new Exception(
        "Could not perform operation, no item is attached to this controller",
      );
    }
  }
}

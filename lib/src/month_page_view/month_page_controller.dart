import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/month_page_view.dart';

class MonthPageController extends CustomPageViewController {
  MonthPageController._internal({
    @required this.initialMonth,
  });

  factory MonthPageController({
    DateTime initialMonth,
  }) {
    initialMonth ??= new DateTime.now();

    return new MonthPageController._internal(
      initialMonth: initialMonth,
    );
  }

  final DateTime initialMonth;

  MonthPageCommunicator _attachedItem;

  void attach(MonthPageCommunicator communicator) {
    _attachedItem = communicator;
  }

  void detach() {
    _attachedItem = null;
  }

  DateTime get currentMonth {
    throwExceptionIfNoItemAttached();

    return _attachedItem.currentMonth();
  }

  void jumpToMonth(DateTime month) {
    throwExceptionIfNoItemAttached();

    _attachedItem.jumpToMonth(month);
  }

  Future<Null> animateToMonth(
    DateTime month, {
    @required Duration duration,
    @required Curve curve,
  }) {
    throwExceptionIfNoItemAttached();

    return _attachedItem.animateToMonth(
      month,
      duration: duration,
      curve: curve,
    );
  }
}

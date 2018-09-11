import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'days_page_communicator.dart';

class DaysPageController {
  DaysPageController._internal({
    @required this.initialDay,
  }) : assert(initialDay != null);

  factory DaysPageController({
    DateTime initialDay,
  }) {
    initialDay ??= new DateTime.now();

    return new DaysPageController._internal(
      initialDay: initialDay,
    );
  }

  final DateTime initialDay;

  DaysPageCommunicator _attachedItem;

  bool get isItemAttached => _attachedItem != null;

  void attach(DaysPageCommunicator communicator) {
    _attachedItem = communicator;
  }

  void detach() {
    _attachedItem = null;
  }

  List<DateTime> displayedDays() {
    _throwExceptionIfNoItemAttached();

    return _attachedItem.displayedDays();
  }

  void jumpToDay(DateTime day) {
    _throwExceptionIfNoItemAttached();

    _attachedItem.jumpToDay(day);
  }

  Future<Null> animateToDay(
    DateTime day, {
    @required Duration duration,
    @required Curve curve,
  }) {
    _throwExceptionIfNoItemAttached();

    return _attachedItem.animateToDay(
      day,
      duration: duration,
      curve: curve,
    );
  }

  void jumpToPage(int page) {
    _throwExceptionIfNoItemAttached();

    _attachedItem.jumpToPage(page);
  }

  Future<Null> animateToPage(
    int page, {
    @required Duration duration,
    @required Curve curve,
  }) {
    _throwExceptionIfNoItemAttached();

    return _attachedItem.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  void _throwExceptionIfNoItemAttached() {
    if (!isItemAttached) {
      throw new Exception(
        "Couln not perform action, No item is attached to this controller",
      );
    }
  }
}

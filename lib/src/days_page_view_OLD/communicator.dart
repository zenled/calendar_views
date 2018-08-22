import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef void JumpToDayCallback(DateTime date);

@immutable
class Communicator {
  Communicator({
    @required this.jumpToDay,
  }) : assert(jumpToDay != null);

  final JumpToDayCallback jumpToDay;
}

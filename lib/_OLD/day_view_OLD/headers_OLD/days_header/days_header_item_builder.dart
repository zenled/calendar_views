import 'package:flutter/material.dart';

import 'days_header.dart';

/// Signature for a function that builds an item that is displayed inside of [DaysHeader].
typedef Widget DaysHeaderItemBuilder(
  BuildContext context,
  DateTime day,
);

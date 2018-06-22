import 'package:meta/meta.dart';

@immutable
class Position {
  const Position({
    @required this.top,
    @required this.left,
  })  : assert(top != null),
        assert(left != null);

  final double top;

  final double left;
}

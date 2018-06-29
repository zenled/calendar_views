import 'package:meta/meta.dart';

@immutable
class ItemPosition {
  const ItemPosition({
    @required this.top,
    @required this.left,
  })  : assert(top != null),
        assert(left != null);

  final double top;

  final double left;
}

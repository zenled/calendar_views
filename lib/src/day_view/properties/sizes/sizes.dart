import 'package:meta/meta.dart';

@immutable
class Sizes {
  const Sizes({
    @required this.totalAvailableWidth,
  }) : assert(totalAvailableWidth != null && totalAvailableWidth > 0);

  final double totalAvailableWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sizes &&
          runtimeType == other.runtimeType &&
          totalAvailableWidth == other.totalAvailableWidth;

  @override
  int get hashCode => totalAvailableWidth.hashCode;

  @override
  String toString() {
    return 'Sizes{totalAvailableWidth: $totalAvailableWidth}';
  }
}

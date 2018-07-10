import 'package:meta/meta.dart';

@immutable
class SizeConstraints {
  const SizeConstraints({
    @required this.availableWidth,
  }) : assert(availableWidth != null && availableWidth > 0);

  final double availableWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeConstraints &&
          runtimeType == other.runtimeType &&
          availableWidth == other.availableWidth;

  @override
  int get hashCode => availableWidth.hashCode;

  @override
  String toString() {
    return 'SizeConstraints{availableWidth: $availableWidth}';
  }
}

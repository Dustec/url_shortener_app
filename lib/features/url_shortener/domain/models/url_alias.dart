import 'package:flutter/foundation.dart';

@immutable
class UrlAlias {
  const UrlAlias({
    required this.alias,
    required this.short,
    required this.original,
  });
  final String alias;
  final String short;
  final String original;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UrlAlias) &&
          alias == other.alias &&
          short == other.short &&
          original == other.original;

  @override
  int get hashCode => Object.hash(
        alias,
        short,
        original,
      );
}

/// A robust library for JSON serialization and deserialization.
library json_conv;

import 'dart:convert';
@MirrorsUsed(metaTargets: const [Conv])
import 'dart:mirrors';

part 'src/annotations.dart';
part 'src/decoding.dart';
part 'src/typeinfo.dart';
part 'src/transformer.dart';
part 'src/encoding.dart';

void registerTransformer(TypeTransformer t, Type type) {
  _convMap[type] = t;
}

class _DateTransformer extends TypeTransformer<DateTime> {
  @override
  DateTime decode(dynamic value) {
    try {
      return DateTime.parse(value);
    } catch (e, st) {
      return null;
    }
  }

  @override
  String encode(DateTime value) {
    if (value == null) return "null";
    return value.toIso8601String();
  }
}

void registerDateTransformer() {
  _convMap[DateTime] = new _DateTransformer();
}

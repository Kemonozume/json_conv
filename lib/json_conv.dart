/// A robust library for JSON serialization and deserialization.
library json_conv;

import 'dart:convert';
import 'dart:mirrors';
import 'package:logging/logging.dart';

part 'src/annotations.dart';
part 'src/decoding.dart';
part 'src/typeinfo.dart';
part 'src/transformer.dart';
part 'src/encoding.dart';

final Logger _logger = new Logger("json_conv");

void registerTransformer(TypeTransformer t, Type type) {
  _convMap[type] = t;
}

class _DateTransformer extends TypeTransformer<DateTime> {
  @override
  DateTime decode(dynamic value) {
    try {
      return DateTime.parse(value);
    } catch (e, st) {
      _logger.info("failed to decode $value");
      _logger.info(e, st);
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

void setLoggingLevel(Level lvl) {
  _logger.level = lvl;
}

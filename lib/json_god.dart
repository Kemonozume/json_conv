/// A robust library for JSON serialization and deserialization.
library json_god;

import 'dart:convert';

import 'package:json_schema/json_schema.dart' show Schema;
import 'src/reflection.dart' as reflection;

part 'src/serialize.dart';
part 'src/deserialize.dart';
part 'src/validation.dart';
part 'src/util.dart';

/// Determines whether JSON God should print (very verbose) debug output!
bool debug = false;
/// A robust library for JSON serialization and deserialization.
library json_conv;

import 'dart:convert';
import 'dart:mirrors';
import 'dart:typed_data';
import 'dart:math';
import 'package:logging/logging.dart';

part 'src/annotations.dart';
part 'src/reflection.dart';

/// set logging level
Level level = Level.ALL;
bool debug = false;
final Logger _logger = new Logger("json_conv")..level = level;

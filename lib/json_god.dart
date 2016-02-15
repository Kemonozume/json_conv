/// A handy library for JSON serialization and deserialization.
///
/// Exposes the God class, which exposes a clean API.
///
/// Source code: [here](https://github.com/thosakwe/json_god)
library json_god;

import 'dart:async';
import 'dart:convert';
@MirrorsUsed(targets: 'json_god')
import 'dart:mirrors';

part 'src/deserialize.dart';

part 'src/serialize.dart';

// Set to true to as required
/// Set this to true to view very verbose JSON encode/decode debug output.
///
/// Name kept for compatiblility with chrisbu/dartwatch-JsonObject.
bool enableJsonObjectDebugMessages = false;

/// In debug mode, logs a message to the console.
void _log(message) {
  if (enableJsonObjectDebugMessages) {
    print('----- DEBUG: $message');
  }
}

/// Asynchronously serializes an object to JSON.
///
/// Kept here solely for compatiblility with chrisbu/dartwatch-JsonObject.
@Deprecated('never')
Future<String> objectToJson(x) => new Future(() => _serializeToJson(x));

/// An almighty class with complete dominion over JSON.
///
/// Allows you to easily serialize and deserialize objects to/from JSON, with a common-sense API.
class God {
  /// Deserializes a JSON string as an Object.
  ///
  /// If you provide a Type as the second parameter, JSONGod will automatically return an instance of that class.
  /// This also allows for schema-like validation of input, to an extent.
  /// If a user provides a field that does not exist, an error will be thrown.
  /// In addition, JSONGod will not assign the values of private members or static members.
  deserialize(String x, [Type y]) => _deserializeFromJson(x, y);
  
  /// Transforms a Map into a Dart object of the given type.
  deserializeFromMap(Map x, [Type y]) => _deserializeObject(x, y);

  /// Magically converts any Dart value into a JSON string.
  ///
  /// Uses dart:mirrors for classes or anything that is not a primitive, List or Map.
  String serialize(x) => _serializeToJson(x);
  
  /// Transforms an object into a Map serializable to JSON.
  String serializeToMap => _serializeObject(x);

  /// Determines whether to print debug output.
  bool get debug => enableJsonObjectDebugMessages;

  /// Determines whether to print debug output.
  set debug(bool value) => enableJsonObjectDebugMessages = value;
}
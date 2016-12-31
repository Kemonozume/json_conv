part of json_god;

/// Serializes any arbitrary Dart datum to JSON. Supports schema validation.
String serialize(value) {
  var serialized = serializeObject(value);

  if (debug) {
    print('Serialization result: $serialized');
  }

  return JSON.encode(serialized);
}

/// Transforms any Dart datum into a value acceptable to JSON.encode.
serializeObject(value) {
  if (_isPrimitive(value)) {
    if (debug) {
      print("Serializing primitive value: $value");
    }

    return value;
  } else if (value is DateTime) {
    if (debug) {
      print("Serializing this DateTime: $value");
    }

    return value.toIso8601String();
  } else if (value is Iterable) {
    if (debug) {
      print("Serializing this Iterable: $value");
    }

    return value.map(serializeObject).toList();
  } else if (value is Map) {
    if (debug) {
      print("Serializing this Map: $value");
    }

    return serializeMap(value);
  } else
    return serializeObject(reflection.serialize(value, serializeObject, debug));
}

/// Recursively transforms a Map and its children into JSON-serializable data.
Map serializeMap(Map value) {
  Map outputMap = {};
  value.forEach((key, value) {
    outputMap[key] = serializeObject(value);
  });
  return outputMap;
}

part of json_conv;

/// Deserializes JSON into data, without validating it.
T deseriaize<T>(String json) {
  print(T);
  Type t = T;
  print(t);
  if (debug) print("Deserializing the following JSON: $json");

  if (debug) {
    print("Now deserializing to type: $T");
  }

  return deserializeDatum(JSON.decode(json), outputType: T);
}

T deserializeMap<T>(Map m) {
  return deserializeDatum(m, outputType: T);
}

/// Deserializes some JSON-serializable value into a usable Dart value.
deserializeDatum(value, {Type outputType}) {
  if (outputType != null) {
    print(outputType);
    return _deserialize(value, outputType, deserializeDatum, debug);
  } else if (value is List) {
    if (debug) {
      print("Deserializing this List: $value");
    }

    return value.map(deserializeDatum).toList();
  } else if (value is Map) {
    if (debug) {
      print("Deserializing this Map: $value");
    }

    Map result = {};
    value.forEach((k, v) {
      result[k] = deserializeDatum(v);
    });
    return result;
  } else if (_isPrimitive(value)) {
    if (debug) {
      print("Value $value is a primitive");
    }

    return value;
  }
}

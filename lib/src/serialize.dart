part of json_god;

String serialize(value, {Schema schema}) {
  var serialized = serializeObject(value);

  if (schema != null) {
    if (debug) {
      print("Serialization result: $serialized");
      print("Validating serialization result via this schema: $schema");
    }

    bool validationResult = schema.validate(serialized);

    if (debug) {
      print("Validation result: ${validationResult ? 'SUCCESS' : 'FAILURE'}");
    }

    if (validationResult) {
      return JSON.encode(serialized);
    } else throw new ValidationError(
        "The given data does not follow the specified schema.",
        serialized,
        schema);
  }

  else return JSON.encode(serialized);
}

serializeObject(value) {
  if (_isPrimitive(value)) {
    if (debug) {
      print("Serializing primitive value: $value");
    }

    return value;
  }
  else if (value is DateTime) {
    if(debug) {
      print("Serializing this DateTime: $value");
    }

    return value.toIso8601String();
  }
  else if (value is Iterable) {
    if (debug) {
      print("Serializing this Iterable: $value");
    }

    return value.map(serializeObject).toList();
  }
  else if (value is Map) {
    if (debug) {
      print("Serializing this Map: $value");
    }

    return serializeMap(value);
  }
  else return reflection.serialize(value, serializeObject, debug);
}

Map serializeMap(Map value) {
  Map outputMap = {};
  value.forEach((key, value) {
    outputMap[key] = serializeObject(value);
  });
  return outputMap;
}

part of json_god;

/// Deserializes a JSON string into a Dart datum. Supports schema validation.
///
/// You can also provide an output Type to attempt to serialize the JSON into.
deserialize(String json, {Type outputType, Schema schema}) {
  var deserialized = deseriaizeJson(json, outputType: outputType);

  if (debug) {
    print("Deserialization result: $deserialized");
  }

  if (schema != null) {
    bool validationResult = schema.validate(deserialized);

    if (debug) {
      print("Validation result: ${validationResult ? 'SUCCESS' : 'FAILURE'}");
    }

    if (validationResult) {
      return deserialized;
    } else
      throw new JsonValidationError(
          "The given data does not follow the specified schema.",
          deserialized,
          schema);
  } else
    return deserialized;
}

/// Deserializes JSON into data, without validating it.
deseriaizeJson(String json, {Type outputType}) {
  if (debug) print("Deserializing the following JSON: $json");

  if (outputType == null) {
    if (debug) {
      print("No output type was specified, so we are just using JSON.decode");
    }

    return JSON.decode(json);
  } else {
    if (debug) {
      print("Now deserializing to type: $outputType");
    }

    return deserializeDatum(JSON.decode(json), outputType: outputType);
  }
}

/// Deserializes some JSON-serializable value into a usable Dart value.
deserializeDatum(value, {Type outputType}) {
  if (outputType != null) {
    return reflection.deserialize(value, outputType, deserializeDatum, debug);
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

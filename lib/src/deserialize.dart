part of json_god;

deserialize(String json, {Type outputType, Schema schema}) {
  var deserialized = _deserializeFromJson(
      json, outputType: outputType, schema: schema);

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
    } else throw new JsonValidationError(
        "The given data does not follow the specified schema.",
        deserialized,
        schema);
  } else return deserialized;
}

_deserializeFromJson(String json, {Type outputType, Schema schema}) {
  if (debug)
    print("Deserializing the following JSON: $json");

  if (outputType == null) {
    if (debug) {
      print("No output type was specified, so we are just using JSON.decode");
    }

    return JSON.decode(json);
  } else {
    if (debug) {
      print("Now deserializing to type: $outputType");
    }

    return _deserializeObject(
        JSON.decode(json), outputType: outputType, schema: schema);
  }
}

_deserializeObject(value, {Type outputType, Schema schema}) {
  if (value is List) {
    return value.map(_deserializeObject).toList();
  } else if (value is Map) {
    Map result = {};
    value.forEach((k, v) {
      result[k] = _deserializeObject(v);
    });
    return result;
  }
}
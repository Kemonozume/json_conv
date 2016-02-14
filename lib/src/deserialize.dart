part of json_god;

/// Decodes a JSON object from input.
_deserializeFromJson(json, [Type outputType]) {
  if (outputType == null) return JSON.decode(json);
  else return _deserializeObject(JSON.decode(json), outputType);
}

/// Deserializes an object received from JSON.
_deserializeObject(value, [Type outputType]) {
  _log("Now deserializing a ${value.runtimeType}");
  if (outputType != null) {
    _log("About to deserialize to a $outputType");
    if (value is List) {
      List<TypeMirror> typeArguments = reflectType(outputType).typeArguments;
      return value.map((item) {
        if (typeArguments.length > 0) return _deserializeObject(
            item, typeArguments[0].reflectedType);
      }).toList();
    } else if (value is Map)
      return _deserializeFromJsonByReflection(value, outputType);
    else return _deserializeObject(value);
  }
  else if (_objectIsPrimitiveType(value)) {
    return value;
  }
  else if (value is Iterable) {
    return value.map((item) => _deserializeObject(item)).toList();
  }
  else if (value is Map) {
    Map outputMap = {};
    value.forEach((k, v) {
      outputMap[k] = _deserializeObject(v);
    });
    return outputMap;
  }
  else {
    _log("You can only deserialize primitives, Lists and Maps from JSON.");
    _log("However, you have provided me with a ${value.runtimeType}.");
    _log("What do expect me to do with this...?");
  }
}

/// Uses mirrors to deserialize an object.
_deserializeFromJsonByReflection(Map data, Type outputType) {
  ClassMirror classMirror = reflectClass(outputType);
  InstanceMirror instanceMirror = classMirror.newInstance(new Symbol(""), []);
  data.keys.forEach((key) {
    _log("Now deserializing value for $key");
    _log("data[\"$key\"] = ${data[key]}");
    var deserializedValue = _deserializeObject(data[key]);
    _log("I want to set $key to the following ${deserializedValue
        .runtimeType}: $deserializedValue");

    // Get target type of getter
    Symbol searchSymbol = new Symbol(key);
    Symbol symbolForGetter = classMirror.instanceMembers.keys.firstWhere((
        x) => x == searchSymbol);
    Type requiredType = classMirror.instanceMembers[symbolForGetter].returnType
        .reflectedType;
    if (data[key].runtimeType != requiredType) {
      _log("Currently, $key is a ${data[key].runtimeType}.");
      _log("However, $key must be a $requiredType.");
      deserializedValue =
          _deserializeObject(deserializedValue, requiredType);
    }
    _log(
        "Final deserialized value for $key: $deserializedValue <${deserializedValue
            .runtimeType}>");
    instanceMirror.setField(new Symbol(key), deserializedValue);
    _log("Success! $key has been set to $deserializedValue");
  }
  );
  return
    instanceMirror.reflectee
  ;
}
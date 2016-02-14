part of json_god;

/// Underlying code for God.serialize.
_serializeToJson(x) {
  return JSON.encode(_serializeObject(x));
}

/// Serializes an instance into an object suitable for JSON encoding.
_serializeObject(x) {
  if (_objectIsPrimitiveType(x)) return _serializePrimitiveObject(x);
  else if (x is List) return _serializeList(x);
  else if (x is Map) return _serializeMap(x);
  else return _serializeObjectByReflection(x);
}

/// Serializes a primitive object to JSON.
_serializePrimitiveObject(x) {
  _log('Serializing primitive: $x (type: ${x.runtimeType})');
  return x;
}

/// Serializes to JSON every item in a list.
_serializeList(List x) {
  _log('Serializing list: $x');
  return ((List list) sync* {
    for (int i = 0; i < list.length; i++)
      yield _serializeObject(list[i]);
  })(x).toList();
}

/// Serializes a Map to JSON.
_serializeMap(Map x) {
  _log('Serializing map: $x');
  Map outputMap = {};
  x.forEach((key, value) {
    outputMap[key] = _serializeObject(value);
  });
  return outputMap;
}

/// Uses reflection to serialization an object that is not a primitive, [Map] or [List].
_serializeObjectByReflection(x) {
  _log('Serializing by reflection: $x');

  Map outputMap = {};
  InstanceMirror instanceMirror = reflect(x);
  ClassMirror classMirror = instanceMirror.type;

  //Get all members and fields
  classMirror.instanceMembers.forEach((Symbol symbol,
      MethodMirror methodMirror) {
    if (!methodMirror.isPrivate && !methodMirror.isStatic &&
        !methodMirror.isOperator) {
      //Only serialize public values! :)
      //_log('Found field: ${methodMirror.qualifiedName}');

      try {
        //Get field, plug it into outputMap
        dynamic reflectee = null;
        if (methodMirror.isGetter) {
          reflectee = instanceMirror
              .getField(symbol)
              .reflectee;
          if (reflectee == x.runtimeType || reflectee == x.hashCode) return;
          _log('Found getter: ${methodMirror.simpleName} = $reflectee');
        }
        else return;
        //Change i.e. Symbol("helloMap") -> helloMap
        String simpleNameForSymbol = symbol.toString().replaceAll(
            new RegExp(r'(^[^\"]+\")|(\"[^[\"]+$)'), '');
        outputMap[simpleNameForSymbol] = !_objectIsPrimitiveType(reflectee)
            ? _serializeObject(reflectee)
            : reflectee;
        _log("Reflected $simpleNameForSymbol as: $reflectee");
      } catch (error) {
        _log("Reflection error: $error");
      }
    }
  });

  _log("Map of reflected values: $outputMap");

  return outputMap;
}

bool _objectIsPrimitiveType(object) =>
    object is num || object is bool || object is String || object == null;
library json_god.reflection;

import 'dart:mirrors';

const Symbol hashCodeSymbol = #hashCode;
const Symbol runtimeTypeSymbol = #runtimeType;

typedef Serializer(value);
typedef Deserializer(value, {Type outputType});

List<Symbol> _findGetters(ClassMirror classMirror, bool debug) {
  List<Symbol> result = [];

  classMirror.instanceMembers
      .forEach((Symbol symbol, MethodMirror methodMirror) {
    if (methodMirror.isGetter &&
        symbol != hashCodeSymbol &&
        symbol != runtimeTypeSymbol) {
      if (debug) print("Found getter on instance: $symbol");
      result.add(symbol);
    }
  });

  return result;
}

Map serialize(value, Serializer serializer, bool debug) {
  if (debug) {
    print("Serializing this value via reflection: $value");
  }

  Map result = {};
  InstanceMirror instanceMirror = reflect(value);
  ClassMirror classMirror = instanceMirror.type;

  for (Symbol symbol in _findGetters(classMirror, debug)) {
    String name = MirrorSystem.getName(symbol);
    var valueForSymbol = instanceMirror.getField(symbol).reflectee;

    result[MirrorSystem.getName(symbol)] = serializer(valueForSymbol);

    if (debug) {
      print("Set $name to $valueForSymbol");
    }
  }

  if (debug) {
    print("Result of serialization via reflection: $result");
  }

  return result;
}

deserialize(value, Type outputType, Deserializer deserializer, bool debug) {
  if (debug) {
    print("About to deserialize to a $outputType");
  }

  if (value is List) {
    List<TypeMirror> typeArguments = reflectType(outputType).typeArguments;

    if (typeArguments.isNotEmpty) {
      return value
          .map((item) =>
              deserializer(item, outputType: typeArguments[0].reflectedType))
          .toList();
    }

    return value.map(deserializer).toList();
  } else if (value is Map)
    return _deserializeFromJsonByReflection(
        value, deserializer, outputType, debug);
  else
    return deserializer(value);
}

/// Uses mirrors to deserialize an object.
_deserializeFromJsonByReflection(
    Map data, Deserializer deserializer, Type outputType, bool debug) {
  ClassMirror classMirror = reflectClass(outputType);
  InstanceMirror instanceMirror = classMirror.newInstance(new Symbol(""), []);
  data.keys.forEach((key) {
    if (debug) {
      print("Now deserializing value for $key");
      print("data[\"$key\"] = ${data[key]}");
    }

    var deserializedValue = deserializer(data[key]);

    if (debug) {
      print(
          "I want to set $key to the following ${deserializedValue.runtimeType}: $deserializedValue");
    }

    // Get target type of getter
    Symbol searchSymbol = new Symbol(key);
    Symbol symbolForGetter =
        classMirror.instanceMembers.keys.firstWhere((x) => x == searchSymbol);
    Type requiredType =
        classMirror.instanceMembers[symbolForGetter].returnType.reflectedType;
    if (data[key].runtimeType != requiredType) {
      if (debug) {
        print("Currently, $key is a ${data[key].runtimeType}.");
        print("However, $key must be a $requiredType.");
      }

      deserializedValue =
          deserializer(deserializedValue, outputType: requiredType);
    }

    if (debug) {
      print(
          "Final deserialized value for $key: $deserializedValue <${deserializedValue.runtimeType}>");
    }

    instanceMirror.setField(new Symbol(key), deserializedValue);

    if (debug) {
      print("Success! $key has been set to $deserializedValue");
    }
  });
  return instanceMirror.reflectee;
}

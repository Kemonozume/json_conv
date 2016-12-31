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

serialize(value, Serializer serializer, bool debug) {
  if (debug) {
    print("Serializing this value via reflection: $value");
  }

  Map result = {};
  InstanceMirror instanceMirror = reflect(value);
  ClassMirror classMirror = instanceMirror.type;

  // Check for toJson
  for (Symbol symbol in classMirror.instanceMembers.keys) {
    if (symbol == #toJson) {
      if (debug) print("Running toJson...");
      var result = instanceMirror.invoke(symbol, []).reflectee;

      if (debug) print("Result of serialization via reflection: $result");
      return result;
    }
  }

  for (Symbol symbol in _findGetters(classMirror, debug)) {
    String name = MirrorSystem.getName(symbol);
    var valueForSymbol = instanceMirror.getField(symbol).reflectee;

    try {
      result[name] = serializer(valueForSymbol);

      if (debug) {
        print("Set $name to $valueForSymbol");
      }
    } catch (e, st) {
      if (debug) {
        print("Could not set $name to $valueForSymbol");
        print(e);
        print(st);
      }
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

  try {
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
  } catch (e) {
    if (debug) {
      print('Deserialization failed.');
      print(e);
    }

    return null;
  }
}

/// Uses mirrors to deserialize an object.
_deserializeFromJsonByReflection(
    data, Deserializer deserializer, Type outputType, bool debug) {
  // Check for fromJson
  ClassMirror type = reflectType(outputType);
  var fromJson =
      new Symbol('${MirrorSystem.getName(type.simpleName)}.fromJson');

  for (Symbol symbol in type.declarations.keys) {
    if (symbol == fromJson) {
      var decl = type.declarations[symbol];

      if (decl is MethodMirror && decl.isConstructor) {
        if (debug) print("Running fromJson...");
        var result = type.newInstance(#fromJson, [data]).reflectee;

        if (debug) print("Result of deserialization via reflection: $result");
        return result;
      }
    }
  }

  ClassMirror classMirror = type;
  InstanceMirror instanceMirror = classMirror.newInstance(new Symbol(""), []);
  data.keys.forEach((key) {
    try {
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
    } catch (e) {
      if (debug) {
        print('Could not set value for field $key.');
        print(e);
      }
    }
  });

  return instanceMirror.reflectee;
}

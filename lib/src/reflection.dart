library json_god.reflection;

import 'dart:mirrors';

const Symbol hashCodeSymbol = #hashCode;
const Symbol runtimeTypeSymbol = #runtimeType;

typedef Serializer(value);

List<Symbol> _findGetters(ClassMirror classMirror, bool debug) {
  List<Symbol> result = [];

  classMirror.instanceMembers.forEach((Symbol symbol,
      MethodMirror methodMirror) {
    if (methodMirror.isGetter && symbol != hashCodeSymbol &&
        symbol != runtimeTypeSymbol) {
      if (debug)
        print("Found getter on instance: $symbol");
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
    var valueForSymbol = instanceMirror
        .getField(symbol)
        .reflectee;

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
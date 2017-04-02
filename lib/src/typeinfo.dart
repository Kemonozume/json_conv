part of json_conv;

var _mirList = reflectType(List);
var _mirMap = reflectType(Map);

bool _isPrimitive(Type value) {
  return value == num ||
      value == bool ||
      value == String ||
      value == null ||
      value == int ||
      value == double;
}

class _Element {
  final Type type;
  final Symbol symbol;
  CImpl cimpl;
  Impl impl;
  bool isMap;
  Type mapType;
  bool isList;
  Type listType;
  bool ignore;
  bool isPrimitive;

  _Element(this.symbol, this.type);

  bool get isComplex => !isList && !isMap;
  @override
  String toString() {
    return "_Element<type> symbol: $symbol, isMap: $isMap, isList: $isList";
  }
}

class _TypeInfo {
  final Type type;
  final ClassMirror mir;
  final Map<String, _Element> elements;
  bool isMap;
  Type mapType;
  bool isList;
  Type listType;
  //only interesting if type is map or list
  bool isPrimitive;

  _TypeInfo(this.type, this.elements, this.isMap, this.mapType, this.isList,
      this.listType, this.mir, this.isPrimitive);
  bool get isComplex => !isList && !isMap;

  @override
  String toString() {
    return "class $type:\n" +
        elements.values.fold("", (a, b) => a + b.toString() + "\n");
  }
}

final _cache = <Type, _TypeInfo>{};

_TypeInfo _generateElements(Type type) {
  if (_cache.containsKey(type)) {
    return _cache[type];
  }
  final classMirror = reflectClass(type);
  final typeMirror = reflectType(type);
  final elements = new Map<String, _Element>();
  bool isMap = false;
  bool isList = false;
  bool isPrimitive;

  Type mapType;
  Type listType;

  if (typeMirror.isAssignableTo(_mirMap)) {
    isMap = true;
    final List<TypeMirror> typeArguments = typeMirror.typeArguments;
    if (typeArguments.length > 1) {
      if (typeArguments[1].hasReflectedType) {
        mapType = typeArguments[1].reflectedType;
        isPrimitive = _isPrimitive(mapType);
      }
    }
  }

  if (typeMirror.isAssignableTo(_mirList)) {
    isList = true;
    final List<TypeMirror> typeArguments = typeMirror.typeArguments;
    if (typeArguments.length > 0) {
      if (typeArguments[0].hasReflectedType) {
        listType = typeArguments[0].reflectedType;
        isPrimitive = _isPrimitive(listType);
      }
    }
  }
  //check super class until we hit Object
  if (classMirror.superclass?.hasReflectedType ?? false) {
    if (classMirror.superclass.reflectedType != Object) {
      final info = _generateElements(classMirror.superclass.reflectedType);
      elements.addAll(info.elements);
    }
  }
  //check fields
  classMirror.declarations.values
      .where((dm) => dm is VariableMirror)
      .forEach((dm) {
    if (dm is VariableMirror) {
      String key = MirrorSystem.getName(dm.simpleName);
      final symbol = dm.simpleName;
      //check for annotation

      if (dm.type.hasReflectedType) {
        final t = dm.type.reflectedType;
        final element = new _Element(symbol, t);

        Property prop = getAnnotation<Property>(dm.metadata);
        if (prop != null) {
          element.ignore = prop.ignore ?? false;
          key = prop.name ?? key;
        }
        element.cimpl = getAnnotation<CImpl>(dm.metadata);
        element.impl = getAnnotation<Impl>(dm.metadata);

        element.isPrimitive = _isPrimitive(t);
        if (dm.type.isAssignableTo(_mirMap)) {
          element.isMap = true;
          final List<TypeMirror> typeArguments = dm.type.typeArguments;
          if (typeArguments.length > 1) {
            if (typeArguments[1].hasReflectedType) {
              element.mapType = typeArguments[1].reflectedType;
              element.isPrimitive = _isPrimitive(element.mapType);
            }
          }
        } else {
          element.isMap = false;
        }
        if (dm.type.isAssignableTo(_mirList)) {
          element.isList = true;
          final List<TypeMirror> typeArguments = typeMirror.typeArguments;
          if (typeArguments.length > 0) {
            if (typeArguments[0].hasReflectedType) {
              element.listType = typeArguments[0].reflectedType;
              element.isPrimitive = _isPrimitive(element.listType);
            }
          }
        } else {
          element.isList = false;
        }
        elements[key] = element;
      }
    }
  });
  final tp = new _TypeInfo(type, elements, isMap, mapType, isList, listType,
      classMirror, isPrimitive);
  _cache[type] = tp;
  return tp;
}

T getAnnotation<T>(List<InstanceMirror> l) {
  if (l.length < 1) return null;
  final mir = l.firstWhere((s) {
    if (!s.hasReflectee) return false;
    if (s.reflectee.runtimeType == T) return true;
    return false;
  }, orElse: () => null);
  return mir?.reflectee ?? null;
}

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
      bool ignore = false;
      if (dm.metadata.length > 0) {
        final im = dm.metadata.firstWhere((s) {
          if (!s.hasReflectee) return false;
          if (s.reflectee.runtimeType == Property) return true;
          return false;
        }, orElse: () => null);
        if (im != null && im.reflectee is Property) {
          //if we found an annotation check if its not empty and use it as key
          if (im.reflectee.hasName && !im.reflectee.ignore) {
            key = im.reflectee.name;
          }
          if (im.reflectee.ignore) {
            ignore = im.reflectee.ignore;
          }
        }
      }
      if (dm.type.hasReflectedType) {
        final t = dm.type.reflectedType;
        final element = new _Element(symbol, t);
        element.ignore = ignore;
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

abstract class _ISetter<T> {
  void add(dynamic key, dynamic value);
  T obj();
}

class _MapSetter implements _ISetter<Map> {
  Map m = {};
  _MapSetter();

  @override
  void add(dynamic key, dynamic value) {
    m[key] = value;
  }

  @override
  Map obj() {
    return m;
  }
}

class _ListSetter<T extends List> implements _ISetter<T> {
  T list = new List();

  @override
  void add(dynamic key, dynamic val) {
    if (key == null) return;
    list.add(val);
  }

  @override
  T obj() {
    return list;
  }
}

class _ComplexSetter<T> implements _ISetter<T> {
  InstanceMirror instance;
  final _TypeInfo info;

  _ComplexSetter(this.info) {
    try {
      instance = info.mir.newInstance(new Symbol(""), []);
    } catch (e) {
      print(info);
      print(info.type);
      throw e;
    }
  }

  @override
  void add(dynamic key, dynamic val) {
    var ele;
    try {
      ele = info.elements[key];
      if (ele != null) {
        instance.setField(ele.symbol, val);
      }
    } catch (e) {
      print(ele);
      print(info);
      throw e;
    }
  }

  @override
  T obj() {
    return instance.reflectee;
  }
}

class BaseSetter<T> {
  final _TypeInfo _info;
  final List keys;
  final List vals;
  int pos;

  BaseSetter(this._info, this.keys, this.vals);

  T _decodeObj<T>(Type type) {
    final info = _generateElements(type);
    _ISetter setter;

    if (info.isComplex) {
      setter = new _ComplexSetter<info.type>(info);
    } else if (info.isList) {
      setter = new _ListSetter<info.type>();
    } else {
      setter = new _MapSetter();
    }

    final length = vals[pos].length;

    for (int i = 0; i < length; i++) {
      pos--;
      Type type;
      dynamic key = keys[pos];
      if (info.isList) {
        type = info.listType;
        key = i;
      }
      if (info.isComplex) {
        final ele = info.elements[keys[pos]];
        if (ele == null || ele.ignore) {
          continue;
        } else {
          info.isPrimitive =
              (ele.isMap || ele.isList) ? false : ele.isPrimitive;
          type = ele.type;
        }
      }
      if (info.isMap) type = info.mapType;
      if (info.isPrimitive) {
        setter.add(key, vals[pos]);
      } else {
        setter.add(key, _decodeObj<type>(type));
      }
    }

    return setter.obj();
  }

  T obj() {
    pos = keys.length - 1;
    assert(keys[pos] == null, "first key has to be null");
    assert(vals[pos] is Map || vals[pos] is List,
        "first value has to be map or list");

    return _decodeObj(_info.type);
  }
}

T decode<T>(String json, Type type) {
  final info = _generateElements(type);
  final keys = new List();
  final vals = new List();
  JSON.decode(json, reviver: (dynamic key, dynamic value) {
    keys.add(key);
    vals.add(value);
  });
  return new BaseSetter<T>(info, keys, vals).obj();
}

T _decodeMap<T>(Object m, Type type) {
  final info = _generateElements(type);
  _ISetter setter;

  if (info.isComplex) {
    setter = new _ComplexSetter<info.type>(info);
  } else if (info.isList) {
    setter = new _ListSetter<info.type>();
  } else {
    setter = new _MapSetter();
  }

  //iterate over info.elements instead of m

  if (m is Map) {
    m.forEach((k, v) {
      final ele = info.elements[k];
      if (ele == null || ele.ignore) {
        return;
      }
      if (ele.isPrimitive) {
        setter.add(k, v);
      } else {
        setter.add(k, _decodeMap<ele.type>(v, ele.type));
      }
    });
  } else if (m is List) {
    if (info.isPrimitive) {
      m.forEach((v) {
        setter.add(0, v);
      });
    } else {
      m.forEach((v) {
        setter.add(0, _decodeMap<info.listType>(v, info.listType));
      });
    }
  }

  return setter.obj();
}

T decodeObj<T>(Object m, Type type) {
  assert(m is List || m is Map);
  return _decodeMap(m, type);
}

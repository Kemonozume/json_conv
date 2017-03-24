part of json_conv;

final Map<Type, TypeTransformer> _convMap = <Type, TypeTransformer>{};

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
      setter = new _ComplexSetter(info);
    } else if (info.isList) {
      setter = new _ListSetter();
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
        if (ele == null) {
          if (vals[pos] is Map || vals[pos] is List) {
            pos -= vals[pos].length;
            continue;
          } else {
            continue;
          }
        } else if (ele.ignore) {
          continue;
        } else {
          info.isPrimitive =
              (ele.isMap || ele.isList) ? false : ele.isPrimitive;
          type = ele.type;
        }
      }
      if (info.isMap) type = info.mapType;
      if (_convMap.containsKey(type)) {
        setter.add(key, _convMap[type].decode(vals[pos]));
      } else if (info.isPrimitive) {
        setter.add(key, vals[pos]);
      } else {
        setter.add(key, _decodeObj(type));
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
    setter = new _ComplexSetter<T>(info);
  } else if (info.isList) {
    //FIXME
    setter = new _ListSetter();
  } else {
    setter = new _MapSetter();
  }

  //iterate over info.elements instead of m
  if (m is List) {
    if (_convMap.containsKey(info.listType)) {
      m.forEach((v) => setter.add(0, _convMap[info.type].decode(v)));
    } else if (info.isPrimitive) {
      m.forEach((v) => setter.add(0, v));
    } else {
      m.forEach((v) => setter.add(0, _decodeMap(v, info.listType)));
    }
  } else if (m is Map) {
    if (info.isComplex) {
      info.elements.keys
          .where((key) => m[key] != null && !info.elements[key].ignore)
          .forEach((key) {
        if (_convMap.containsKey(info.elements[key].type)) {
          setter.add(key, _convMap[info.elements[key].type].decode(m[key]));
        } else if (info.elements[key].isPrimitive) {
          setter.add(key, m[key]);
        } else {
          setter.add(key, _decodeMap(m[key], info.elements[key].type));
        }
      });
    } else if (info.isMap) {
      m.forEach((k, v) {
        if (_convMap.containsKey(info.mapType)) {
          setter.add(k, _convMap[info.mapType].decode(v));
        } else if (info.isPrimitive) {
          setter.add(k, v);
        } else {
          setter.add(k, _decodeMap(v, info.mapType));
        }
      });
    }
  }
  return setter.obj();
}

T decodeObj<T>(Object m, Type type) {
  assert(m is List || m is Map);
  return _decodeMap<T>(m, type);
}

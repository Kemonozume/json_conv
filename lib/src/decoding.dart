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
  final _Element info;

  _ComplexSetter(this.info) {
    try {
      instance = info.cm.newInstance(_emptySymbol, []);
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
      ele = info.children[key];
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
  final _Element _info;
  final List keys;
  final List vals;
  int pos;

  BaseSetter(this._info, this.keys, this.vals);

  T _decodeObj<T>(Type type) {
    final info = _generateElements(type);
    final length = vals[pos].length;
    if (info.prop?.ignore ?? false) {
      pos -= length;
      return null;
    }

    switch (info.ctype) {
      case _CmplxType.LIST:
        final list = new List(length);
        for (int i = 0; i < length; i++) {
          pos--;
          if (info.children.values.first.ctype == _CmplxType.PRIMITIVE) {
            list[i] = vals[pos];
          } else if (_convMap.containsKey(info.children.values.first.type)) {
            list[i] =
                _convMap[info.children.values.first.type].decode(vals[pos]);
          } else if (info.children.values.first.ctype ==
              _CmplxType.TYPESEEKER) {
            final type = _getTypeSeeker(info.children.values.first);
            list[i] = _decodeObj(type);
          } else {
            list[i] = _decodeObj(info.children.values.first.type);
          }
        }
        return list as T;
      case _CmplxType.MAP:
        final map = new Map<String, dynamic>();
        for (int i = 0; i < length; i++) {
          pos--;
          if (info.children.values.first.ctype == _CmplxType.PRIMITIVE) {
            map[keys[pos]] = vals[pos];
          } else if (_convMap.containsKey(info.children.values.first.type)) {
            map[keys[pos]] =
                _convMap[info.children.values.first.type].decode(vals[pos]);
          } else {
            map[keys[pos]] = _decodeObj(info.children.values.first.type);
          }
        }
        return map as T;
      case _CmplxType.OBJECT:
        final instance = info.cm.newInstance(_emptySymbol, []);
        _Element ele;
        for (int i = 0; i < length; i++) {
          pos--;
          ele = info.children[keys[pos]];
          if (ele == null) {
            if (vals[pos] is Map) {
              // int length2 = vals[pos].length;
              // for (int b = 0; b < length2; b++) {
              //   pos--;
              //   if (vals[pos] is Map || vals[pos] )
              // }
              //if is list check if next pos-- is object or list? get length of that multiple to list length ?

              pos -= vals[pos].length;
              continue;
            } else if (vals[pos] is List) {
              if (vals[pos - 1] is List || vals[pos - 1] is Map) {
                pos -= (vals[pos].length * vals[pos - 1].length) +
                    vals[pos].length;
              }
              continue;
            } else {
              continue;
            }
          } else if (ele.ignore) {
            continue;
          }
          if (ele.ctype == _CmplxType.PRIMITIVE) {
            instance.setField(ele.symbol, vals[pos]);
          } else if (_convMap.containsKey(ele.type)) {
            instance.setField(ele.symbol, _convMap[ele.type].decode(vals[pos]));
          } else if (ele.ctype == _CmplxType.TYPESEEKER) {
            final type = _getTypeSeeker(ele);
            instance.setField(ele.symbol, _decodeObj(type));
          } else {
            instance.setField(ele.symbol, _decodeObj(ele.type));
          }
        }
        return instance.reflectee;
      case _CmplxType.TYPESEEKER:
        if (info.typeSeeker == null ||
            info.typeSeeker.key == null ||
            info.typeSeeker.key.isEmpty ||
            info.typeSeeker.finder == null)
          throw new StateError("typeseeker not configured correctly");
        final type = _getTypeSeeker(info);
        if (type == null) return null;
        return _decodeObj(type);
      default:
        throw new StateError("base object cant be primitive");
    }
  }

  int getLengthMap(int pos2) {}

  Type _getTypeSeeker(_Element ele) {
    Type type;
    int length;
    if (vals[pos] is Map) length = vals[pos].values.length;
    if (vals[pos] is List) length = vals[pos].length;
    for (int i = pos; i >= pos - length; i--) {
      if (keys[i] == ele.typeSeeker.key) {
        type = ele.typeSeeker.finder(vals[i]);
        break;
      }
    }
    if (type == null) {
      type = ele.typeSeeker.finder(null);
      if (type == null) {
        throw new StateError(
            "typeseeker failed to find type for ${ele.type}, ${ele.symbol.toString}, ${ele.ctype}");
      }
    }
    return type;
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

  switch (info.ctype) {
    case _CmplxType.LIST:
      setter = new _ListSetter();
      break;
    case _CmplxType.MAP:
      setter = new _MapSetter();
      break;
    case _CmplxType.OBJECT:
      setter = new _ComplexSetter<T>(info);
      break;
    default:
      throw new StateError("base object cant be primitive");
  }

  //iterate over info.elements instead of m
  if (m is List) {
    if (_convMap.containsKey(info.children.values.first.type)) {
      m.forEach((v) => setter.add(0, _convMap[info.type].decode(v)));
    } else if (info.children.values.first.ctype == _CmplxType.PRIMITIVE) {
      m.forEach((v) => setter.add(0, v));
    } else {
      m.forEach(
          (v) => setter.add(0, _decodeMap(v, info.children.values.first.type)));
    }
  } else if (m is Map) {
    if (info.ctype == _CmplxType.OBJECT) {
      info.children.keys
          .where((key) => m[key] != null && !info.children[key].ignore)
          .forEach((key) {
        if (_convMap.containsKey(info.children[key].type)) {
          setter.add(key, _convMap[info.children[key].type].decode(m[key]));
        } else if (info.children[key].ctype == _CmplxType.PRIMITIVE) {
          setter.add(key, m[key]);
        } else {
          setter.add(key, _decodeMap(m[key], info.children[key].type));
        }
      });
    } else if (info.ctype == _CmplxType.MAP) {
      m.forEach((k, v) {
        if (_convMap.containsKey(info.children.values.first.type)) {
          setter.add(k, _convMap[info.children.values.first.type].decode(v));
        } else if (info.children.values.first.ctype == _CmplxType.PRIMITIVE) {
          setter.add(k, v);
        } else {
          setter.add(k, _decodeMap(v, info.children.values.first.type));
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

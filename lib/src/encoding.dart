part of json_conv;

String encode(Object obj) {
  return JSON.encode(_encode(obj));
}

Object _encode(Object object) {
  if (_isPrimitive(object.runtimeType) || object == null) {
    return object;
  } else if (object is Map) {
    object.forEach((k, v) {
      object[k] = _encode(v);
    });
    return object;
  } else if (object is List) {
    return object.map((k) => _encode(k)).toList();
  } else {
    //complex object
    //check if its in the convMap first
    if (_convMap.containsKey(object.runtimeType))
      return _convMap[object.runtimeType].encode(object);
    else
      return _objectToMap(object);
  }
}

Map _objectToMap(Object obj) {
  final info = _generateElements(obj.runtimeType);
  final m = <String, dynamic>{};
  info.elements.forEach((k, v) {
    if (v.ignore) return;
    final im = reflect(obj);
    m[k] = im.getField(v.symbol).reflectee;
  });
  return _encode(m);
}

part of json_conv;

final _encoder = new JsonEncoder(_encodeObj);
const _classOpen = 0x7B;
const _classClose = 0x7D;
const _arrayOpen = 0x5B;
const _arrayClose = 0x5D;
const _comma = 0x2C;
const _quote = 0x22;
const _colon = 0x3A;

String encode(Object obj) {
  return _encoder.convert(obj);
}

String encode2(Object obj) {
  return new _Encoder().encode(obj);
}

dynamic _encodeObj(dynamic obj) {
  if (obj is Map) {
    obj.forEach((k, v) {
      if (_isPrimitive(v)) {
        obj[k] = v;
      } else {
        obj[k] = _encodeObj(v);
      }
    });
    return obj;
  } else if (obj is List) {
    return obj.map((k) {
      if (_isPrimitive(k.runtimeType)) return k;
      return _encodeObj(k);
    }).toList();
  } else {
    //complex obj
    //check if its in the convMap first
    if (_convMap.containsKey(obj.runtimeType)) {
      return _convMap[obj.runtimeType].encode(obj);
    } else {
      return _objectToMap(obj);
    }
  }
}

Map _objectToMap(Object obj) {
  final info = _generateElements(obj.runtimeType);
  final m = <String, dynamic>{};
  info.children.forEach((k, v) {
    if (v.ignore) return;
    final im = reflect(obj);
    final key = v.prop?.name ?? k;
    final val = im.getField(v.symbol).reflectee;
    if (_isPrimitive(val.runtimeType)) {
      m[key] = val;
    } else {
      m[key] = _encodeObj(val);
    }
  });

  return m;
}

class _Encoder {
  StringBuffer buffer;

  _Encoder() {
    buffer = new StringBuffer();
  }

  String encode(dynamic obj) {
    _encode(obj);
    return buffer.toString();
  }

  void _encode(dynamic obj) {
    if (obj is Map) {
      buffer.writeCharCode(_classOpen);
      final length = obj.keys.length;
      final last = length - 1;
      for (int i = 0; i < length; i++) {
        buffer.writeCharCode(_quote);
        buffer.write(obj.keys.elementAt(i));
        buffer.writeCharCode(_quote);
        buffer.writeCharCode(_colon);
        if (_isPrimitive(obj.values.elementAt(i).runtimeType)) {
          if (obj.values.elementAt(i) is String) {
            buffer.writeCharCode(_quote);
            buffer.write(obj.values.elementAt(i));
            buffer.writeCharCode(_quote);
          } else {
            buffer.write(obj.values.elementAt(i));
          }
        } else {
          _encode(obj.values.elementAt(i));
        }
        if (i != last) {
          buffer.writeCharCode(_comma);
        }
      }
      buffer.writeCharCode(125);
    } else if (obj is List) {
      buffer.writeCharCode(_arrayOpen);
      final length = obj.length;
      final last = length - 1;
      for (int i = 0; i < length; i++) {
        if (_isPrimitive(obj[i].runtimeType)) {
          if (obj[i] is String) {
            buffer.writeCharCode(_quote);
            buffer.write(obj[i]);
            buffer.writeCharCode(_quote);
          } else {
            buffer.write(obj[i]);
          }
        } else {
          _encode(obj[i]);
        }
        if (i != last) {
          buffer.writeCharCode(_comma);
        }
      }
      buffer.writeCharCode(_arrayClose);
    } else {
      if (_convMap.containsKey(obj.runtimeType)) {
        buffer.write(_convMap[obj.runtimeType].encode(obj));
      } else {
        buffer.writeCharCode(_classOpen);
        final info = _generateElements(obj.runtimeType);
        final length = info.children.keys.length;
        final last = length - 1;
        final im = reflect(obj);
        for (int i = 0; i < length; i++) {
          if (info.children.values.elementAt(i).ignore) continue;

          buffer.writeCharCode(_quote);
          buffer.write(info.children.values.elementAt(i).prop?.name ??
              info.children.keys.elementAt(i));
          buffer.writeCharCode(_quote);
          buffer.writeCharCode(_colon);

          final val =
              im.getField(info.children.values.elementAt(i).symbol).reflectee;

          if (_isPrimitive(val.runtimeType)) {
            if (val is String) {
              buffer.writeCharCode(_quote);
              buffer.write(val);
              buffer.writeCharCode(_quote);
            } else {
              buffer.write(val);
            }
          } else {
            _encode(val);
          }

          if (i != last) {
            buffer.writeCharCode(_colon);
          }
        }
        buffer.writeCharCode(_classClose);
      }
    }
  }
}

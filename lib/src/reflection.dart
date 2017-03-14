part of json_conv;

const _openArray = 91;
const _closeArray = 93;
const _openClass = 123;
const _closeClass = 125;
const _comma = 44;
const _quote = 34;
const _white = 32;
const _colon = 58;
const _boolTrue = 116;
const _boolFalse = 102;
const _newLine = 10;
const _dot = 46;
var _mirList = reflectType(List);
var _mirMap = reflectType(Map);

final _convMap = <Type, Function>{
  bool: _bytesToBool,
  int: _bytesToInt,
  String: _bytesToString,
  double: _bytesToDouble
};

typedef int Seek(List<int> l, int start, {bool end});
final _seekMap = <Type, Seek>{
  bool: _seekNumberOrBool,
  int: _seekNumberOrBool,
  double: _seekNumberOrBool,
  String: _seekString,
  List: _seekList,
  Element: _seekClass
};

class Element {
  final Type type;
  final Symbol symbol;
  final String key;
  bool isMap;
  bool isList;

  Element(this.key, this.symbol, this.type);

  @override
  String toString() {
    return "Element<$type> key: $key, symbol: $symbol, isMap: $isMap, isList: $isList";
  }
}

class TypeInfo {
  final Type type;
  final List<Element> elements;
  bool isMap;
  bool isList;

  TypeInfo(this.type, this.elements, this.isMap, this.isList);

  String toString() {
    return "class $type:\n" +
        elements.fold("", (a, b) => a + b.toString() + "\n");
  }
}

final _cache = <Type, TypeInfo>{};

TypeInfo generateElements(Type type) {
  if (_cache.containsKey(type)) {
    return _cache[type];
  }
  ClassMirror classMirror = reflectClass(type);
  TypeMirror typeMirror = reflectType(type);
  List<Element> elements = new List<Element>();
  bool isMap = false;
  bool isList = false;
  if (typeMirror.isAssignableTo(_mirMap)) {
    isMap = true;
  }

  if (typeMirror.isAssignableTo(_mirList)) {
    isList = true;
  }
  //check super class until we hit Object
  if (classMirror.superclass?.hasReflectedType ?? false) {
    if (classMirror.superclass.reflectedType != Object) {
      final info = generateElements(classMirror.superclass.reflectedType);
      elements.addAll(info.elements);
    }
  }
  //check fields
  final list = classMirror.declarations.values
      .where((dm) => dm is VariableMirror)
      .toList();

  list.forEach((dm) {
    if (dm is VariableMirror) {
      String key = MirrorSystem.getName(dm.simpleName);
      Symbol symbol = dm.simpleName;
      //check for annotation
      if (dm.metadata.length > 0) {
        final im = dm.metadata.firstWhere((s) {
          if (!s.hasReflectee) return false;
          if (s.reflectee.runtimeType == Property) return true;
          return false;
        }, orElse: () => null);
        if (im != null && im.reflectee is Property) {
          //if we found an annotation check if its not empty and use it as key
          final newkey = im.reflectee.name;
          if (newkey.isNotEmpty) {
            key = newkey;
          }
        }
      }
      if (dm.type.hasReflectedType) {
        Type t = dm.type.reflectedType;
        final element = new Element(key, symbol, t);
        if (dm.type.isAssignableTo(_mirMap)) {
          element.isMap = true;
        } else {
          element.isMap = false;
        }
        if (dm.type.isAssignableTo(_mirList)) {
          element.isList = true;
        } else {
          element.isList = false;
        }
        elements.add(element);
      }
    }
  });
  var tp = new TypeInfo(type, elements, isMap, isList);
  _cache[type] = tp;
  return tp;
}

Uint8List stringToByteArray(String json) {
  List<int> encoded;
  try {
    encoded = UTF8.encode(json);
  } on ArgumentError {
    return null;
  }
  return new Uint8List.fromList(encoded);
}

//check if we can drop toList()
//FIXME
double _bytesToDouble(List<int> l) {
  return double.parse(UTF8.decode(l));
}

int _bytesToInt(List<int> l) {
  return int.parse(UTF8.decode(l));
}

String _bytesToString(List<int> l) {
  if (l.length == 2) return "";
  l.remove(_quote);
  l.remove(_quote);
  return UTF8.decode(l);
}

bool _bytesToBool(dynamic l) {
  if (l is int) if (l == _boolTrue) return true;
  if (l.first == _boolTrue) return true;
  return false;
}

int _seekList(List<int> l, int start, {bool end: false}) {
  int count = 0; //used to skip nested arrays as well;
  bool inQuote = false;
  for (int c = start; c < l.length; c++) {
    if (l[c] == _quote) {
      if (inQuote == true) {
        inQuote = false;
      } else {
        inQuote = true;
      }
    }
    if (l[c] == _openArray) {
      if (inQuote) continue;
      if (!end) return c;
      count++;
      continue;
    }
    if (l[c] == _closeArray) {
      if (inQuote) continue;
      if (count == 0) {
        return c + 1;
      }
      count--;
    }
  }
  throw new StateError(
      "could not find start or end of list from position $start, end: $end");
}

int _seekString(List<int> l, int start, {bool end: false}) {
  for (int c = start; c < l.length; c++) {
    if (l[c] == _quote) {
      if (end) return c + 1;
      return c;
    }
  }
  throw new StateError(
      "could not find start or end of string from position $start, end: $end");
}

int _seekClass(List<int> l, int start, {bool end: false}) {
  int count = 0;
  bool inQuote = false;
  for (int c = start; c < l.length; c++) {
    if (l[c] == _quote) {
      if (inQuote == true) {
        inQuote = false;
      } else {
        inQuote = true;
      }
    }
    if (l[c] == _openClass) {
      if (inQuote) continue;
      if (end) {
        count++;
      } else {
        return c;
      }
    }

    if (l[c] == _closeClass) {
      if (inQuote) continue;
      if (count == 0) {
        return c + 1;
      }
      if (end) {
        count--;
      }
    }
  }
  throw new StateError(
      "could not find start or end of class from position $start, end: $end");
}

int _seekNumberOrBool(List<int> l, int start, {bool end: false}) {
  bool inQuote = false;
  for (int c = start; c < l.length; c++) {
    if (l[c] == _quote) {
      if (inQuote == true) {
        inQuote = false;
      } else {
        inQuote = true;
      }
    }
    if (l[c] == _comma ||
        l[c] == _white ||
        l[c] == _newLine ||
        l[c] == _colon ||
        l[c] == _quote ||
        l[c] == _closeArray ||
        l[c] == _closeClass ||
        l[c] == _openArray ||
        l[c] == _openClass) {
      if (end) {
        return c;
      }
      continue;
    } else {
      if (!end && !inQuote) return c;
    }
  }
  return l.length;
}

class TypeWrap {
  final Type type;
  final int end;

  TypeWrap(this.type, this.end);
}

TypeWrap _seekType(List<int> l, int start) {
  Type type;
  int end = -1;
  int sstart = -1;
  _seekMap.forEach((t, f) {
    try {
      int starttmp = 0;
      int endtmp = 0;
      starttmp = f(l, start);
      if (sstart == -1) {
        sstart = starttmp;
      }
      endtmp = f(l, starttmp + 1, end: true);
      if (endtmp - starttmp > end && starttmp <= sstart) {
        end = endtmp - starttmp;
        sstart = starttmp;
        type = t;
      }
    } catch (_) {}
  });
  if (type == Element) {
    return new TypeWrap(Map, end);
  }
  if (type == num || type == bool || type == int) {
    if (l.contains(_boolTrue)) {
      return new TypeWrap(bool, end);
    }
    if (l.contains(_boolFalse)) {
      return new TypeWrap(bool, end);
    }
    return new TypeWrap(num, end);
  }
  return new TypeWrap(type ?? dynamic, end);
}

bool _isPrimitive(Type value) {
  return value == num ||
      value == bool ||
      value == String ||
      value == null ||
      value == int ||
      value == double;
}

// add to test file lol
class TestWrapSeek {
  final String json;
  final String result;
  final int start;
  final Function f;

  TestWrapSeek(this.json, this.result, this.start, this.f);
}

void test12() {
  var list = <TestWrapSeek>[
    new TestWrapSeek(' {  } ', '{  }', 0, _seekClass),
    new TestWrapSeek(' { { {}}  } ', '{ { {}}  }', 0, _seekClass),
    new TestWrapSeek(' { { {}}  } ', '{ {}}', 2, _seekClass),
    new TestWrapSeek('{  [] }', '{  [] }', 0, _seekClass),
    new TestWrapSeek(' {  } ', '{  }', 0, _seekClass),
    new TestWrapSeek(
        ' {"key": "value{}" } ', '{"key": "value{}" }', 0, _seekClass),
    new TestWrapSeek(' {"key": "{" } ', '{"key": "{" }', 0, _seekClass),
    new TestWrapSeek('""', '""', 0, _seekString),
    new TestWrapSeek('"test  \n"', '"test  \n"', 0, _seekString),
    new TestWrapSeek('"test \t"', '"test \t"', 0, _seekString),
    new TestWrapSeek('"  ""', '""', 2, _seekString),
    new TestWrapSeek('[]', '[]', 0, _seekList),
    new TestWrapSeek('[ [ ] [ ] []]', '[ [ ] [ ] []]', 0, _seekList),
    new TestWrapSeek(' [  ] ', '[  ]', 0, _seekList),
    new TestWrapSeek(' ["[", "" ] ', '["[", "" ]', 0, _seekList),
    new TestWrapSeek('{"test": 0.1} ', '0.1', 0, _seekNumberOrBool),
    new TestWrapSeek('{"test": true} ', 'true', 0, _seekNumberOrBool),
    new TestWrapSeek('{"test": false} ', 'false', 0, _seekNumberOrBool),
    new TestWrapSeek(' 0.1', '0.1', 0, _seekNumberOrBool),
    new TestWrapSeek('0.1  ', '0.1', 0, _seekNumberOrBool),
  ];

  list.forEach((w) {
    try {
      var start = w.f(UTF8.encode(w.json), w.start);
      var end = w.f(UTF8.encode(w.json), start + 1, end: true);
      if (w.result !=
          UTF8.decode(UTF8.encode(w.json).getRange(start, end).toList())) {
        print(
            "test failed\n json should be ${w.result} but is ${UTF8.decode(UTF8.encode(w.json).getRange(start, end).toList())}");
      }
    } catch (e) {
      print(
          "crashed test\n json: ${w.json}\n result: ${w.result}\n pos: ${w.start}");
      print(e);
    }
  });
}

class TestWrapType {
  final String json;
  final Type type;
  final int start;
  TestWrapType(this.json, this.start, this.type);
}

void test13() {
  var list = <TestWrapType>[
    new TestWrapType(' {  } ', 0, Map),
    new TestWrapType(' [] ', 0, List),
    new TestWrapType(' "" ', 0, String),
    new TestWrapType(' 0.12 ', 0, num),
    new TestWrapType(' true ', 0, bool),
    new TestWrapType(' 1 ', 0, num),
  ];

  list.forEach((w) {
    TypeWrap t = _seekType(UTF8.encode(w.json), w.start);
    if (t.type != w.type) {
      print(
          "test failed\n type for ${w.json} should be ${w.type} but is ${t.type}");
    }
  });
}

//FIXME delet this
String debugJson;
T decode<T>(String json, Type type) {
  debugJson = json;
  var res = _consumeList<T>(UTF8.encode(json), type);
  return res.data;
}

class _Result<T> {
  T data;
  int end;

  _Result(this.data, this.end);
}

_Result<T> _consumeList<T>(List<int> list, Type type,
    {int position: 0, bool onlyOne: false}) {
  final info = generateElements(type);
  ClassMirror classMirror = reflectType(type);
  InstanceMirror instance;
  try {
    instance = classMirror.newInstance(new Symbol(""), []);
  } catch (_) {}

  Map<String, dynamic> m;
  if (info.isMap) {
    m = new Map<String, dynamic>();
  }
  //flag if we read the starting class opening or not
  bool afterKey = false;
  String key;

  int idx = position;
  while (idx < list.length) {
    int char = list[idx];
    switch (char) {
      case _openClass:
        break;

      case _closeClass:
        if (onlyOne) {
          return new _Result<T>(instance.reflectee, idx);
        }
        break;

      case _openArray:
        var endArray = _seekMap[List](list, idx + 1, end: true) - 1;
        int length = endArray - idx;
        Type arrayType;

        //set type from element info (object)
        var ele =
            info.elements.firstWhere((e) => e.key == key, orElse: () => null);
        if (ele != null) {
          final List<TypeMirror> typeArguments =
              reflectType(ele.type).typeArguments;
          arrayType = typeArguments[0].reflectedType;
        } else {
          //object itself is an array so no ele info?
          final List<TypeMirror> typeArguments =
              reflectType(type).typeArguments;
          arrayType = typeArguments[0].reflectedType;
        }
        List<arrayType> valueList = new List<arrayType>();

        int end = 0;
        if (_isPrimitive(arrayType)) {
          while (idx < endArray) {
            int start = _seekMap[arrayType](list, idx);
            end = _seekMap[arrayType](list, start + 1, end: true);
            valueList
                .add(_convMap[arrayType](list.getRange(start, end).toList()));
            idx = end + 1;
          }
        } else {
          //array of arrays???
          while (idx < endArray) {
            var wat = _consumeList<arrayType>(list, arrayType,
                position: idx + 1, onlyOne: true);
            valueList.add(wat.data);
            idx = wat.end + 1;
          }
        }

        if (info.isList) {
          return new _Result<List<arrayType>>(valueList, idx);
        } else if (ele != null && instance != null) {
          instance.setField(ele.symbol, valueList);
        } else {
          throw new StateError("element null and not a list? invalid json");
        }

        break;
      case _closeArray: //end of array
        break;
      case _quote: //read key, read type of ele
        int start = idx;
        int end = _seekMap[String](list, start + 1, end: true);
        key = _convMap[String](list.getRange(start, end).toList());
        idx = end;

        Type valueType;

        var ele =
            info.elements.firstWhere((e) => e.key == key, orElse: () => null);
        if (ele != null) {
          valueType = ele.type;
        } else if (info.isMap) {
          TypeWrap tw = _seekType(list, idx);
          valueType = tw.type;
        } else {
          TypeWrap tw = _seekType(list, idx);
          idx = tw.end + 1;
          continue;
        }
        if (_isPrimitive(valueType)) {
          int start = _seekMap[valueType](list, idx);
          int end = _seekMap[valueType](list, start + 1, end: true);
          if (info.isMap) {
            m[key] = _convMap[valueType](list.getRange(start, end).toList());
          } else {
            instance.setField(ele.symbol,
                _convMap[valueType](list.getRange(start, end).toList()));
          }
          idx = end;
        } else {
          var wat = _consumeList<valueType>(list, valueType,
              position: idx, onlyOne: true);
          if (info.isMap) {
            m[key] = wat.data;
          } else {
            instance.setField(ele.symbol, wat.data);
          }
          idx = wat.end;
        }
        break;
      case _colon: //ignore :
      case _white: //ignore whtiespace
      case _comma: //ignore ,
      case _newLine:
        break;
      default:
    }
    idx++;
  }

  if (info.isMap) return new _Result<Map<String, dynamic>>(m, idx);
  return new _Result<T>(instance.reflectee, idx);
}

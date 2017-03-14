import 'package:json_conv/json_conv.dart';
import 'package:logging/logging.dart';
import 'dart:convert';
import 'package:json_god/json_god.dart' as god;

class Simple {
  int id;
  String text;

  @override
  String toString() {
    return "$id: $text";
  }
}

class Test {
  @Property(name: "_id")
  int id;

  @Property(name: "_lol??")
  String value;

  bool real;

  double tellme;

  @override
  String toString() {
    return "$id: $value, $real, $tellme";
  }
}

class Test1 {
  List<String> strings;

  @override
  String toString() {
    return "$strings";
  }
}

class Test2 {
  Test test;
  List<String> strings;

  @override
  String toString() {
    return "Test2: ${test.toString()} $strings";
  }
}

class Test3 extends Test {
  String text2;
}

class Test4 extends Test3 {
  String text3;

  @override
  String toString() {
    return "$id: $value, $real, $tellme, $text2, $text3";
  }
}

class Test5 {
  String text2;
  Simple simple;

  @override
  String toString() {
    return "${simple.id}: ${simple.text}, $text2";
  }
}

class Test6 {
  List<Simple> simple;

  @override
  String toString() {
    return simple.fold("Test6: \n", (a, b) => a + b.toString() + "\n");
  }
}

void test<T>(Test t, Type i) {
  final Type d = T;
  print(d);
  print("${d == i}");
  if (t.runtimeType == d) {
    print("is ${t.runtimeType}");
  } else {
    print("is not ${t.runtimeType}");
  }
}

// {: [123]
// }: [125]
// ,: [44]
// [: [91]
// ]: [93]
// ": [34]
//  : 32
// :: 58
void printChars() {
  final l = ["{", "}", ",", "[", "]", '"', ' ', ":", "t", "f", ".", "\n"];
  l.forEach((str) => print("$str: ${str.codeUnits}"));
}

var list =
    '{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]}';

void main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  //test<Test>(new Test(), Test);
  //printChars();

  // test12();
  // test13();

  // Stopwatch w = new Stopwatch();
  // w.start();
  // var b = JSON.decode(list);
  // print(b.length);
  // w.stop();
  // print(w.elapsedMilliseconds);

  Stopwatch w = new Stopwatch();
  w.start();
  for (int i = 0; i < 5000; i++) {
    var b = decode<Test6>(list, Test6);
  }
  w.stop();
  print("decode took: ${w.elapsedMilliseconds}");

  w.reset();
  w.start();
  for (int i = 0; i < 5000; i++) {
    var b = god.deseriaizeJson(list, outputType: Test6);
  }
  w.stop();
  print("json god took: ${w.elapsedMilliseconds}");

  // w.reset();

  // String json = '{"id": 2, "text":"lol"}';
  // print(json);
  // var b = decode(json, Simple);
  // print(b);
  // print("");

  // json = '["a", "b","c" , "d"  , "a", "", "   "]';
  // print(json);
  // b = decode<List<String>>(json, new List<String>().runtimeType);
  // print(b);
  // print("");

  // print('{"_id":1000, "_lol??": "wat", "real": true, "tellme": 2.20}');
  // b = decode(
  //     '{"_id":1000, "_lol??": "wat", "real": true, "tellme": 2.20}', Test);
  // print(b);
  // print("");

  // print(
  //     '{"_id":0, "_lol??": "wat", "real": true, "tellme": 0.1001, "text2": "lol", "test3":"lol2"}');
  // b = decode(
  //     '{"_id":0, "_lol??": "wat", "real": true, "tellme": 0.1001, "text2": "lol", "test3":"lol2"}',
  //     Test4);
  // print(b);
  // print("");

  // print('{"strings": ["lol", "1", "2"]}');
  // b = decode('{"strings": ["lol", "1", "2"]}', Test1);
  // print(b);
  // print("");

  // print('{"text2": "test", "simple": { "id": 23, "text": "test text" }}');
  // b = decode(
  //     '{"text2": "test", "simple": { "id": 23, "text": "test text" }}', Test5);
  // print(b);
  // print("");

  // json =
  //     '{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]}';
  // print(json);
  // b = decode(json, Test6);
  // print(b);
  // print("");

  // var json = '{"test": 2, "lol": "lol"}';
  // print(json);
  // var b = decode(json, Map);
  // print(b);
}

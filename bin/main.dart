import 'package:json_conv/json_conv.dart';
import 'package:logging/logging.dart';
import 'dart:convert';
import 'package:json_god/json_god.dart' as god;
import 'package:dartson/dartson.dart' as d;

@d.Entity()
class Simple {
  int id;
  String text;

  Simple();

  @override
  String toString() {
    return "$id: $text";
  }
}

class SimpleWithSimple {
  int id;
  Simple simple;
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
  SimpleWithSimple simple1;

  @override
  String toString() {
    return "Test1: ${simple1.id} ${simple1.simple.toString()}";
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

@d.Entity()
class Test6 {
  List<Simple> simple;

  Test6();

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
    '''[{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},
{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]}]''';

void main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  //test<Test>(new Test(), Test);
  //printChars();

  // test12();
  // test13();

  // String json = '{"id": 2, "text":"lol"}';
  // print(decodeTest<Simple>(json, Simple));

  //print(decodeTest<List<Test6>>(list, new List<Test6>().runtimeType));
  int its = 2000;
  Stopwatch w = new Stopwatch();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = JSON.decode(list);
  // }
  // w.stop();
  // print("JSON.decode took: ${w.elapsedMilliseconds}");

  // w.reset();
  w.start();
  for (int i = 0; i < its; i++) {
    var b = decodeTest<List<Test6>>(list, new List<Test6>().runtimeType);
    //print(b.length);
  }
  w.stop();
  print("decodeTest took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decodeMap(JSON.decode(list), new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decodeMap took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decode<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = god.deseriaizeJson(list, outputType: new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("json god took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // var dson = new d.Dartson.JSON();
  // for (int i = 0; i < its; i++) {
  //   var b = dson.decode(list, new Test6(), true);
  //   //print(b.length);
  // }
  // w.stop();
  // print("dartson took: ${w.elapsedMilliseconds}");

  // w.reset();

  // String json = '{"id": 2, "text":"lol"}';
  // print(json);
  // var b = decodeTest<Simple>(json, Simple);
  // print(b);
  // print("");

  // json = '["a", "b","c" , "d"  , "a", "", "   "]';
  // print(json);
  // var c = decodeTest<List<String>>(json, new List<String>().runtimeType);
  // print(c);
  // print("");

  // print('{"_id":1000, "_lol??": "wat", "real": true, "tellme": 2.20}');
  // var d = decodeTest<Test>(
  //     '{"_id":1000, "_lol??": "wat", "real": true, "tellme": 2.20}', Test);
  // print(d);
  // print("");

  // print(
  //     '{"_id":0, "_lol??": "wat", "real": true, "tellme": 0.1001, "text2": "lol", "test3":"lol2"}');
  // var g = decodeTest<Test4>(
  //     '{"_id":0, "_lol??": "wat", "real": true, "tellme": 0.1001, "text2": "lol", "test3":"lol2"}',
  //     Test4);
  // print(g);
  // print("");

  // json = '{"simple1": {"id" : 2, "simple": {"id": 1, "text": "2"}}}';
  // print(json);
  // var e = decodeTest<Test1>(json, Test1);
  // print(e);
  // print("");

  // var json = '{"text2": "test", "simple": { "id": 23, "text": "test text" }}';
  // print(json);
  // var f = decodeTest<Test5>(
  //     '{"text2": "test", "simple": { "id": 23, "text": "test text" }}', Test5);
  // print(f);
  // print("");

  // json =
  //     '{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]}';
  // print(json);
  // var h = decodeTest<Test6>(json, Test6);
  // print(h);
  // print("");

  // var json = '{"test": 2, "lol": "lol"}';
  // print(json);
  // var b = decode(json, Map);
  // print(b);
}

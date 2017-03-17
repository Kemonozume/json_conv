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

@d.Entity()
class Test6 {
  List<Simple> simple;

  Test6();

  @override
  String toString() {
    return simple.fold("Test6: \n", (a, b) => a + b.toString() + "\n");
  }
}

class AnnotationSample2 {
  int id;

  @Property(name: "test1")
  String text;

  AnnotationSample2();

  AnnotationSample2.withValues(this.id, this.text);
}

class MapComplex {
  Map<String, Person> persons;
}

class MapSimple {
  Map<String, String> persons;
}

class Person {
  String name;
}

class Male {
  Person person;
  String test;
}

// void test<T>(Test t, Type i) {
//   final Type d = T;
//   print(d);
//   print("${d == i}");
//   if (t.runtimeType == d) {
//     print("is ${t.runtimeType}");
//   } else {
//     print("is not ${t.runtimeType}");
//   }
// }

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

  final json =
      '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
  final sample = decodeTest<MapComplex>(json, MapComplex);
  print(sample.persons);

  // int its = 2000;
  // Stopwatch w = new Stopwatch();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = JSON.decode(list);
  // }
  // w.stop();
  // print("JSON.decode took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decodeTest<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 3rd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decode<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 1st version took: ${w.elapsedMilliseconds}");

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
}

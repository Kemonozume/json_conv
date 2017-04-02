import 'package:logging/logging.dart';
import 'package:json_conv/json_conv.dart';
import 'dart:convert';

void test<T>(Type i) {
  final Type d = T;
  print(d);
  print(T);
  print(i);
  print("${d == i}");
}

final json = '{"obj":{"time": "2017-02-09T12:05:38.387000+00:00"}}';

class DateTimeTest {
  DateTimeTest2 obj;
}

class DateTimeTest2 {
  DateTime time;
}

class Person {
  String name;
}

class Student extends Person {
  String schule;
}

class Uni {
  String name;
  List<Student> students;
}

class Person2 {
  @Property(name: "test")
  String name;

  @Property(ignore: true)
  String test2;

  String nulltest;
}

void main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  registerDateTransformer();

  // final sample = decodeObj<DateTimeTest>(JSON.decode(json), DateTimeTest);
  // print(sample.obj.time.toString());

  // final person = new Person();
  // person.name = "testname";
  // var jso = encode(person);
  // print(jso);

  // final student = new Student();
  // student
  //   ..name = "testname"
  //   ..schule = "testschule";
  // jso = encode(student);
  // print(jso);

  // final uni = new Uni();
  // uni.name = "hs-weingartne";
  // uni.students = new List<Student>();
  // uni.students.add(new Student()
  //   ..name = "testname1"
  //   ..schule = "testschule1");
  // uni.students.add(new Student()
  //   ..name = "testname2"
  //   ..schule = "testschule2");
  // uni.students.add(new Student()
  //   ..name = "testname3"
  //   ..schule = "testschule3");
  // jso = encode(uni);
  // print(jso);

  // final p2 = new Person2();
  // p2.name = "testname";
  // jso = encode(p2);
  // print(jso);

  final p3 = new Person2();
  p3.name = "testname";
  p3.test2 = "test2";
  var jso = encode(p3);
  print(jso);

  // final json =
  //     '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
  // final sample = decodeTest<MapComplex>(json, MapComplex);
  // print(sample.persons);

  // int its = 20000;
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
  //   var b = decode<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 3rd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decodeObj<List<Test6>>(
  //       JSON.decode(list), new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 2nd version took: ${w.elapsedMilliseconds}");

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

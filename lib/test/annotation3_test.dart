import 'package:json_conv/json_conv.dart';
import 'package:test/test.dart';

@Conv()
abstract class Person {
  int id;
  String name;
}

@Conv()
class Student extends Person {
  String dorm;
}

@Conv()
class Professor extends Person {
  String faculty;
}

@Conv()
class NotValidPerson {
  int id;
}

@Conv()
class Response {
  @Implementation(Professor)
  Person person;
}

@Conv()
class Response2 {
  @Implementation(NotValidPerson)
  Person person;
}

void main() {
  test('validImplementationAnnotation', () {
    final json =
        '{"person":{"id": 0, "name":"test professor", "faculty":"test fac"}}';
    final p = decode(json, Response);

    expect(p.person.id, equals(0));
    //0 index because order of array is reversed for now FIXME: sort right
    expect(p.person.runtimeType, equals(Professor));
    expect((p.person as Professor).faculty, equals("test fac"));
  });
  test('invalidImplementationAnnotation', () {
    expect(() {
      final json =
          '{"person":{"id": 0, "name":"test professor", "faculty":"test fac"}}';
      final p = decode(json, Response2);
    }, throws);
  });
}

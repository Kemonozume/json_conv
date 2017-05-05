import 'package:json_conv/json_conv.dart';

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
class Response {
  @TypeSeeker("dorm", seekPerson)
  List<Person> persons;
}

Type seekPerson(dynamic val) {
  if (val == null) {
    return Professor;
  }
  return Student;
}

@Conv()
abstract class Channel {
  int id;
  String type;
}

@Conv()
class TextChannel extends Channel {
  String topic;
}

@Conv()
class VoiceChannel extends Channel {
  int bitrate;
}

@Conv()
class ResponseChannel {
  @TypeSeeker("type", seekChannel)
  List<Channel> channel;
}

Type seekChannel(dynamic val) {
  if (val == "text") {
    return TextChannel;
  } else if (val == "voice") {
    return VoiceChannel;
  } else {
    print("unknown type $val");
    return null; //will throw an StateError
  }
}

void main() {
  registerDateTransformer();

  var json =
      '{"persons":[{"id": 0, "name":"test student", "dorm":"test dorm"}, {"id": 1, "name":"test professor", "faculty":"test fac"}]}';
  final p = decode(json, Response);
  print(p.persons);
  print(encode(p));

  json =
      '{"channel": [{"id":0, "type":"text", "topic":"test topic"}, {"id":1, "type":"voice", "bitrate":65000}]}';
  final c = decode(json, ResponseChannel);
  print(c.channel);
  print(encode(c));

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

  // final p3 = new Person2();
  // p3.name = "testname";
  // p3.test2 = "test2";
  // var jso = encode(p3);
  // print(jso);

  // final json =
  //     '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
  // final sample = decodeTest<MapComplex>(json, MapComplex);
  // print(sample.persons);
}

import 'package:json_conv/json_conv.dart';
import 'package:test/test.dart';

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
  test('missingKeyAnnotation', () {
    final json =
        '{"persons":[{"id": 0, "name":"test student", "dorm":"test dorm"}, {"id": 1, "name":"test professor", "faculty":"test fac"}]}';
    final p = decode(json, Response);

    expect(p.persons.length, equals(2));
    //0 index because order of array is reversed for now FIXME: sort right
    expect(p.persons[0].name, equals("test professor"));
    expect(p.persons[0].faculty, equals("test fac"));
  });

  test('validTypeSeekerAnnotation', () {
    final json =
        '{"channel": [{"id":0, "type":"text", "topic":"test topic"}, {"id":1, "type":"voice", "bitrate":65000}]}';
    final c = decode(json, ResponseChannel);

    expect(c.channel.length, equals(2));
    //0 index because order of array is reversed for now FIXME: sort right
    expect(c.channel[0].type, equals("voice"));
    expect(c.channel[1].topic, equals("test topic"));
  });
}

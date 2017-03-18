import 'package:json_conv/json_conv.dart' as conv;
import 'package:test/test.dart';
import 'shared.dart';

void main() {
  group('stringDecoding', () {
    test('extendedDecoding', () {
      final json = '{"id":1, "text":"test text", "isValid":false}';
      final sample = conv.decode<ExtenderClass>(json, ExtenderClass);

      expect(sample, new isInstanceOf<ExtenderClass>());
      expect(sample.id, equals(1));
      expect(sample.text, equals("test text"));
      expect(sample.isValid, equals(false));
    });
    test('listComplexDecoding', () {
      final json =
          '{"list": [{"id":0, "text":"0"}, {"id":1, "text":"1"},{"id":2, "text":"2"}]}';
      final sample = conv.decode<ListComplex>(json, ListComplex);

      expect(sample, isNotNull);
      expect(sample.list.length, equals(3));
      for (int i = 0; i < 3; i++) {
        final val = sample.list.firstWhere(
            (e) => e.text == i.toString() && e.id == i,
            orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listComplexDecoding2', () {
      final json =
          '[{"id":0, "text":"0"}, {"id":1, "text":"1"},{"id":2, "text":"2"}]';
      final sample = conv.decode<List<ExtendeeClass>>(
          json, new List<ExtendeeClass>().runtimeType);

      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      for (int i = 0; i < 3; i++) {
        final val = sample.firstWhere(
            (e) => e.text == i.toString() && e.id == i,
            orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listSimpleDecoding', () {
      final json = '{"list": ["0", "1", "2", "3"]}';
      final sample = conv.decode<ListSimple>(json, ListSimple);

      expect(sample, isNotNull);
      expect(sample.list.length, equals(4));
      for (int i = 0; i < 4; i++) {
        final val = sample.list
            .firstWhere((e) => e == i.toString(), orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listSimpleDecoding2', () {
      final json = '["0", "1", "2", "3"]';
      final sample =
          conv.decode<List<String>>(json, new List<String>().runtimeType);

      expect(sample, isNotNull);
      expect(sample.length, equals(4));
      for (int i = 0; i < 4; i++) {
        final val =
            sample.firstWhere((e) => e == i.toString(), orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('embedDecoding', () {
      final json = '{"test": "test string", "person":{"name": "name"}}';
      final sample = conv.decode<Male>(json, Male);

      expect(sample, isNotNull);
      expect(sample.test, equals("test string"));
      expect(sample.person.name, equals("name"));
    });
    test('mapComplexDecoding', () {
      final json =
          '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
      final sample = conv.decode<MapComplex>(json, MapComplex);

      expect(sample, isNotNull);
      expect(sample.persons, isNotNull);
      expect(sample.persons.length, equals(3));
      expect(sample.persons["person1"].name, equals("name"));
      expect(sample.persons["person2"].name, equals("name2"));
      expect(sample.persons["person3"].name, equals("name3"));
    });
    test('mapComplexDecoding2', () {
      final json =
          '{"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}';
      final sample = conv.decode<Map<String, Person>>(
          json, new Map<String, Person>().runtimeType);

      expect(sample, isNotNull);
      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      expect(sample["person1"].name, equals("name"));
      expect(sample["person2"].name, equals("name2"));
      expect(sample["person3"].name, equals("name3"));
    });
    test('mapSimpleDecoding', () {
      final json =
          '{"persons": {"person1": "name","person2":"name2","person3": "name3"}}';
      final sample = conv.decode<MapSimple>(json, MapSimple);

      expect(sample, isNotNull);
      expect(sample.persons, isNotNull);
      expect(sample.persons.length, equals(3));
      expect(sample.persons["person1"], equals("name"));
      expect(sample.persons["person2"], equals("name2"));
      expect(sample.persons["person3"], equals("name3"));
    });
    test('mapSimpleDecoding2', () {
      final json = '{"person1": "name","person2":"name2","person3": "name3"}';
      final sample = conv.decode<Map<String, String>>(
          json, new Map<String, String>().runtimeType);

      expect(sample, isNotNull);
      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      expect(sample["person1"], equals("name"));
      expect(sample["person2"], equals("name2"));
      expect(sample["person3"], equals("name3"));
    });
  });

  group('mapDecoding', () {
    test('extendedDecoding', () {
      final m = {"id": 1, "text": "test text", "isValid": false};
      final sample = conv.decodeObj<ExtenderClass>(m, ExtenderClass);

      expect(sample, new isInstanceOf<ExtenderClass>());
      expect(sample.id, equals(1));
      expect(sample.text, equals("test text"));
      expect(sample.isValid, equals(false));
    });
    test('listComplexDecoding', () {
      final m = {
        "list": [
          {"id": 0, "text": "0"},
          {"id": 1, "text": "1"},
          {"id": 2, "text": "2"}
        ]
      };
      final sample = conv.decodeObj<ListComplex>(m, ListComplex);

      expect(sample, isNotNull);
      expect(sample.list.length, equals(3));
      for (int i = 0; i < 3; i++) {
        final val = sample.list.firstWhere(
            (e) => e.text == i.toString() && e.id == i,
            orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listComplexDecoding2', () {
      final m = [
        {"id": 0, "text": "0"},
        {"id": 1, "text": "1"},
        {"id": 2, "text": "2"}
      ];
      final sample = conv.decodeObj<List<ExtendeeClass>>(
          m, new List<ExtendeeClass>().runtimeType);

      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      for (int i = 0; i < 3; i++) {
        final val = sample.firstWhere(
            (e) => e.text == i.toString() && e.id == i,
            orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listSimpleDecoding', () {
      final m = {
        "list": ["0", "1", "2", "3"]
      };
      final sample = conv.decodeObj<ListSimple>(m, ListSimple);

      expect(sample, isNotNull);
      expect(sample.list.length, equals(4));
      for (int i = 0; i < 4; i++) {
        final val = sample.list
            .firstWhere((e) => e == i.toString(), orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('listSimpleDecoding2', () {
      final m = ["0", "1", "2", "3"];
      final sample =
          conv.decodeObj<List<String>>(m, new List<String>().runtimeType);

      expect(sample, isNotNull);
      expect(sample.length, equals(4));
      for (int i = 0; i < 4; i++) {
        final val =
            sample.firstWhere((e) => e == i.toString(), orElse: () => null);
        expect(val, isNotNull);
      }
    });
    test('embedDecoding', () {
      final m = {
        "test": "test string",
        "person": {"name": "name"}
      };
      final sample = conv.decodeObj<Male>(m, Male);

      expect(sample, isNotNull);
      expect(sample.test, equals("test string"));
      expect(sample.person.name, equals("name"));
    });
    test('mapComplexDecoding', () {
      final m = {
        "persons": {
          "person1": {"name": "name"},
          "person2": {"name": "name2"},
          "person3": {"name": "name3"}
        }
      };
      final sample = conv.decodeObj<MapComplex>(m, MapComplex);

      expect(sample, isNotNull);
      expect(sample.persons, isNotNull);
      expect(sample.persons.length, equals(3));
      expect(sample.persons["person1"].name, equals("name"));
      expect(sample.persons["person2"].name, equals("name2"));
      expect(sample.persons["person3"].name, equals("name3"));
    });
    test('mapComplexDecoding2', () {
      final json = {
        "person1": {"name": "name"},
        "person2": {"name": "name2"},
        "person3": {"name": "name3"}
      };
      final sample = conv.decodeObj<Map<String, Person>>(
          json, new Map<String, Person>().runtimeType);

      expect(sample, isNotNull);
      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      expect(sample["person1"].name, equals("name"));
      expect(sample["person2"].name, equals("name2"));
      expect(sample["person3"].name, equals("name3"));
    });
    test('mapSimpleDecoding', () {
      final json = {
        "persons": {"person1": "name", "person2": "name2", "person3": "name3"}
      };
      final sample = conv.decodeObj<MapSimple>(json, MapSimple);

      expect(sample, isNotNull);
      expect(sample.persons, isNotNull);
      expect(sample.persons.length, equals(3));
      expect(sample.persons["person1"], equals("name"));
      expect(sample.persons["person2"], equals("name2"));
      expect(sample.persons["person3"], equals("name3"));
    });
    test('mapSimpleDecoding2', () {
      final json = {"person1": "name", "person2": "name2", "person3": "name3"};
      final sample = conv.decodeObj<Map<String, String>>(
          json, new Map<String, String>().runtimeType);

      expect(sample, isNotNull);
      expect(sample, isNotNull);
      expect(sample.length, equals(3));
      expect(sample["person1"], equals("name"));
      expect(sample["person2"], equals("name2"));
      expect(sample["person3"], equals("name3"));
    });
  });
}

import 'package:json_conv/json_conv.dart' as conv;
import 'package:test/test.dart';
import 'shared.dart';

void main() {
  group('encoding', () {
    test('simplePersonTest', () {
      final Person p = new Person()..name = null;
      final sample = conv.encode(p);
      // this line crashes: RangeError (index): Invalid value: Valid value range is empty: 1
      expect(sample, isNotNull);
    });
    test('extendedEncoding', () {
      final json = '{"id":1, "text":"test text", "isValid":false}';
      final sample = conv.decode<ExtenderClass>(json, ExtenderClass);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"id":1'), equals(true));
      expect(json2.contains('"text":"test text"'), equals(true));
      expect(json2.contains('"isValid":false'), equals(true));
    });
    test('listComplexEncoding', () {
      final json =
          '{"list": [{"id":0, "text":"0"}, {"id":1, "text":"1"},{"id":2, "text":"2"}]}';
      final sample = conv.decode<ListComplex>(json, ListComplex);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('{"id":0,"text":"0"}'), equals(true));
      expect(json2.contains('"list":['), equals(true));
      expect(json2.contains('}]}'), equals(true));
    });
    test('listComplexEncoding2', () {
      final json =
          '[{"id":0, "text":"0"}, {"id":1, "text":"1"},{"id":2, "text":"2"}]';
      final sample = conv.decode<List<ExtendeeClass>>(
          json, new List<ExtendeeClass>().runtimeType);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('{"id":0,"text":"0"}'), equals(true));
      expect(json2.contains('}]'), equals(true));
    });
    test('listSimpleEncoding', () {
      final json = '{"list": ["0", "1", "2", "3"]}';
      final sample = conv.decode<ListSimple>(json, ListSimple);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"list":['), equals(true));
      expect(json2.contains('"0"'), equals(true));
    });
    test('listSimpleEncoding2', () {
      final json = '["0", "1", "2", "3"]';
      final sample =
          conv.decode<List<String>>(json, new List<String>().runtimeType);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('['), equals(true));
      expect(json2.contains('"0"'), equals(true));
    });
    test('embedEncoding', () {
      final json = '{"test": "test string", "person":{"name": "name"}}';
      final sample = conv.decode<Male>(json, Male);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"test":"test string"'), equals(true));
      expect(json2.contains('"person":{'), equals(true));
    });
    test('mapComplexEncoding', () {
      final json =
          '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
      final sample = conv.decode<MapComplex>(json, MapComplex);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"person1":{"name":"name"}'), equals(true));
      expect(json2.contains('"persons":{'), equals(true));
    });
    test('mapComplexEncoding2', () {
      final json =
          '{"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}';
      final sample = conv.decode<Map<String, Person>>(
          json, new Map<String, Person>().runtimeType);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"person1":{'), equals(true));
      expect(json2.contains('"person2":{'), equals(true));
      expect(json2.contains('}}'), equals(true));
    });
    test('mapSimpleEncoding', () {
      final json =
          '{"persons": {"person1": "name","person2":"name2","person3": "name3"}}';
      final sample = conv.decode<MapSimple>(json, MapSimple);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"persons":{'), equals(true));
      expect(json2.contains('"person2":"name2"'), equals(true));
      expect(json2.contains('}}'), equals(true));
    });
    test('mapSimpleEncoding2', () {
      final json = '{"person1": "name","person2":"name2","person3": "name3"}';
      final sample = conv.decode<Map<String, String>>(
          json, new Map<String, String>().runtimeType);

      final json2 = conv.encode(sample);
      expect(json2.replaceAll(" ", "").length,
          equals(json.replaceAll(" ", "").length));
      expect(json2.contains('"person1":"name"'), equals(true));
    });
  });
}

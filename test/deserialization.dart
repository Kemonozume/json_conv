import 'package:json_god/json_god.dart' as god;
import 'package:json_schema/json_schema.dart' show Schema;
import 'package:test/test.dart';
import 'shared.dart';

main() {
  god.debug = true;

  group('deserialization', () {
    test('deserialize primitives', testDeserializationOfPrimitives);

    test('serialize dates', testDeserializationOfDates);

    test('serialize maps', testDeserializationOfMaps);

    test('serialize lists + reflection',
        testDeserializationOfListsAsWellAsViaReflection);

    test('serialize with schema validation',
        testDeserializationWithSchemaValidation);
  });
}

testDeserializationOfPrimitives() {
  expect(god.deserialize('"1"'), equals(1));
  expect(god.deserialize('"1.4"'), equals(1.4));
  expect(god.deserialize('"Hi!"'), equals("Hi!"));
  expect(god.deserialize("true"), equals(true));
  expect(god.deserialize("null"), equals(null));
}

testDeserializationOfDates() {
  DateTime date = new DateTime.now();
  String json = '{"date":"${date.toIso8601String()}"}';

  Map deserialized = god.deserialize(json);
  expect(deserialized['date'] is DateTime, equals(true));
  expect(deserialized['date'].millisecondsSinceEpoch,
      equals(date.millisecondsSinceEpoch));
}

testDeserializationOfMaps() {
  String simpleJson = '{"hello":"world", "one": 1, "class": {"hello": "world"}}';
  String nestedJson = '{"foo": {"bar": "baz", "funny": {"how": "life", "seems": 2, "hate": "us sometimes"}}}';
  Map simple = god.deserialize(simpleJson);
  Map nested = god.deserialize(nestedJson);

  expect(simple['hello'], equals('world'));
  expect(simple['one'], equals(1));
  expect(simple['class']['hello'], equals('world'));

  expect(nested['foo']['bar'], equals('baz'));
  expect(nested['foo']['funny']['how'], equals('life'));
  expect(nested['foo']['funny']['seems'], equals(2));
  expect(nested['foo']['funny']['hate'], equals('us sometimes'));
}

testDeserializationOfListsAsWellAsViaReflection() {
  String json = '''[
    {
      "hello": "world",
      "nested": []
    },
    {
      "hello": "dolly",
      "nested": [
        {
          "bar": "baz"
        },
        {
          "bar": "fight"
        }
      ]
    }
  ]
  ''';

  List<SampleClass> list = god.deserialize(
      json, outputType: new List<SampleClass>().runtimeType);
  SampleClass first = list[0];
  SampleClass second = list[1];

  expect(list.length, equals(2));
  expect(first.hello, equals("world"));
  expect(first.nested.length, equals(0));
  expect(second.hello, equals("dolly"));
  expect(second.nested.length, equals(2));

  SampleNestedClass firstNested = second.nested[0];
  SampleNestedClass secondNested = second.nested[1];

  expect(firstNested.bar, equals("baz"));
  expect(secondNested.bar, equals("fight"));
}

testDeserializationWithSchemaValidation() async {
  Schema babelRcSchema = await Schema.createSchemaFromUrl(
      'http://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/babelrc.json');
  String babelRcJson = '{"presets":["es2015","stage-0"],"plugins":["add-module-exports"]}';

  Map deserialized = god.deserialize(babelRcJson, outputType: BabelRc);

  expect(deserialized['presets'] is List, equals(true));
  expect(deserialized['presets'].length, equals(2));
  expect(deserialized['presets'][0], equals('es2015'));
  expect(deserialized['presets'][1], equals('stage-0'));
  expect(deserialized['plugins'] is List, equals(true));
  expect(deserialized['plugins'].length, equals(1));
  expect(deserialized['plugins'][0], equals('add-module-exports'));

  expect(() {
    String babelRcJson = '{"presets":"Hello, world!"}';
    god.deserialize(babelRcJson, schema: babelRcSchema);
  }, throwsA(new isInstanceOf<god.JsonValidationError>()));
}

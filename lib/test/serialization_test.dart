import 'dart:convert' show JSON;
import 'package:json_conv/json_conv.dart' as conv;
import 'package:test/test.dart';
import 'shared.dart';

main() {
  conv.debug = false;

  group('serialization', () {
    test('serialize primitives', testSerializationOfPrimitives);

    test('serialize dates', testSerializationOfDates);

    test('serialize maps', testSerializationOfMaps);

    test('serialize lists', testSerializationOfLists);

    test('serialize via reflection', testSerializationViaReflection);

    test('serialize with schema validation',
        testSerializationWithSchemaValidation);
  });
}

testSerializationOfPrimitives() {
  expect(conv.serialize(1), equals("1"));
  expect(conv.serialize(1.4), equals("1.4"));
  expect(conv.serialize("Hi!"), equals('"Hi!"'));
  expect(conv.serialize(true), equals("true"));
  expect(conv.serialize(null), equals("null"));
}

testSerializationOfDates() {
  DateTime date = new DateTime.now();
  String json = conv.serialize({'date': date});

  print(json);

  Map deserialized = JSON.decode(json);
  expect(deserialized['date'], equals(date.toIso8601String()));
}

testSerializationOfMaps() {
  Map simple = JSON.decode(conv.serialize(
      {'hello': 'world', 'one': 1, 'class': new SampleClass('world')}));
  Map nested = JSON.decode(conv.serialize({
    'foo': {
      'bar': 'baz',
      'funny': {'how': 'life', 'seems': 2, 'hate': 'us sometimes'}
    }
  }));

  expect(simple['hello'], equals('world'));
  expect(simple['one'], equals(1));
  expect(simple['class']['hello'], equals('world'));

  expect(nested['foo']['bar'], equals('baz'));
  expect(nested['foo']['funny']['how'], equals('life'));
  expect(nested['foo']['funny']['seems'], equals(2));
  expect(nested['foo']['funny']['hate'], equals('us sometimes'));
}

testSerializationOfLists() {
  List pandorasBox = [
    1,
    "2",
    {"num": 3, "four": new SampleClass('five')},
    new SampleClass('six')..nested.add(new SampleNestedClass('seven'))
  ];
  String json = conv.serialize(pandorasBox);
  print(json);

  List deserialized = JSON.decode(json);

  expect(deserialized is List, equals(true));
  expect(deserialized.length, equals(4));
  expect(deserialized[0], equals(1));
  expect(deserialized[1], equals("2"));
  expect(deserialized[2] is Map, equals(true));
  expect(deserialized[2]['num'], equals(3));
  expect(deserialized[2]['four'] is Map, equals(true));
  expect(deserialized[2]['four']['hello'], equals('five'));
  expect(deserialized[3] is Map, equals(true));
  expect(deserialized[3]['hello'], equals('six'));
  expect(deserialized[3]['nested'] is List, equals(true));
  expect(deserialized[3]['nested'].length, equals(1));
  expect(deserialized[3]['nested'][0] is Map, equals(true));
  expect(deserialized[3]['nested'][0]['bar'], equals('seven'));
}

testSerializationViaReflection() {
  SampleClass sample = new SampleClass('world');

  for (int i = 0; i < 3; i++) {
    sample.nested.add(new SampleNestedClass('baz'));
  }

  String json = conv.serialize(sample);
  print(json);

  Map deserialized = JSON.decode(json);
  expect(deserialized['hello'], equals('world'));
  expect(deserialized['nested'] is List, equals(true));
  expect(deserialized['nested'].length == 3, equals(true));
  expect(deserialized['nested'][0]['bar'], equals('baz'));
  expect(deserialized['nested'][1]['bar'], equals('baz'));
  expect(deserialized['nested'][2]['bar'], equals('baz'));
}

testSerializationWithSchemaValidation() async {
  BabelRc babelRc = new BabelRc(
      presets: ['es2015', 'stage-0'], plugins: ['add-module-exports']);

  String json = conv.serialize(babelRc);
  print(json);

  Map deserialized = JSON.decode(json);

  expect(deserialized['presets'] is List, equals(true));
  expect(deserialized['presets'].length, equals(2));
  expect(deserialized['presets'][0], equals('es2015'));
  expect(deserialized['presets'][1], equals('stage-0'));
  expect(deserialized['plugins'] is List, equals(true));
  expect(deserialized['plugins'].length, equals(1));
  expect(deserialized['plugins'][0], equals('add-module-exports'));

  Map babelRc2 = {'presets': 'Hello, world!'};

  String json2 = conv.serialize(babelRc);
  print(json2);
}
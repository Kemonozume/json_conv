import 'package:json_conv/json_conv.dart' as conv;
import 'package:test/test.dart';

main() {
  test('fromJson', () {
    conv.debug = false;
    Foo foo = conv.deserialize('{"bar":"baz"}', outputType: Foo);

    expect(foo, new isInstanceOf<Foo>());
    expect(foo.text, equals('baz'));
  });

  test('toJson', () {
    var foo = new Foo(text: 'baz');
    var data = conv.serializeObject(foo);
    expect(data, equals({'bar': 'baz', 'foo': 'poobaz'}));
  });
}

class Foo {
  String text;

  String get foo => 'poo$text';

  Foo({this.text});

  factory Foo.fromJson(Map json) => new Foo(text: json['bar']);

  Map toJson() => {'bar': text, 'foo': foo};
}

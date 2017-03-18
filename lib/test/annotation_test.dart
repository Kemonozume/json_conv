import 'package:json_conv/json_conv.dart' as conv;
import 'package:test/test.dart';

void main() {
  test('validAnnotation', () {
    final orig = new AnnotationSample.withValues(1, "test text");
    final json = '{"id":1, "test":"test text"}';
    final sample = conv.decode<AnnotationSample>(json, AnnotationSample);

    expect(sample, new isInstanceOf<AnnotationSample>());
    expect(sample, equals(orig));
  });

  test('wrongNamedAnnotation', () {
    final json = '{"id":1, "test":"test text"}';
    final sample = conv.decode<AnnotationSample2>(json, AnnotationSample2);

    expect(sample, isNotNull);
    expect(sample, new isInstanceOf<AnnotationSample2>());
    expect(sample.id, equals(1));
    expect(sample.text, equals(null));
  });

  test('ignoreAnnotation', () {
    final json = '{"id":1, "text":"test text"}';
    final sample = conv.decode<AnnotationSample3>(json, AnnotationSample3);
    expect(sample, isNotNull);
    expect(sample, new isInstanceOf<AnnotationSample3>());
    expect(sample.id, equals(1));
    expect(sample.text, equals(null));
  });

  test('ignoreAnnotation2', () {
    final json = '{"id":1, "text":"test text"}';
    final sample = conv.decode<AnnotationSample4>(json, AnnotationSample4);
    expect(sample, isNotNull);
    expect(sample, new isInstanceOf<AnnotationSample4>());
    expect(sample.id, equals(1));
    expect(sample.text, equals("test text"));
  });
}

class AnnotationSample {
  int id;

  @conv.Property(name: "test")
  String text;

  AnnotationSample();

  AnnotationSample.withValues(this.id, this.text);

  bool operator ==(dynamic o) =>
      o is AnnotationSample && o.id == id && o.text == text;
}

class AnnotationSample2 {
  int id;

  @conv.Property(name: "test1")
  String text;

  AnnotationSample2();

  AnnotationSample2.withValues(this.id, this.text);
}

class AnnotationSample3 {
  int id;

  @conv.Property(ignore: true)
  String text;

  AnnotationSample3();

  AnnotationSample3.withValues(this.id, this.text);
}

class AnnotationSample4 {
  int id;

  @conv.Property(ignore: false)
  String text;

  AnnotationSample4();

  AnnotationSample4.withValues(this.id, this.text);
}

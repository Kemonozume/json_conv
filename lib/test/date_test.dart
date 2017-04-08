import 'package:json_conv/json_conv.dart';
import 'package:test/test.dart';
import 'dart:convert';

class DateTimeTest {
  DateTime time;
}

void main() {
  registerDateTransformer();
  test('dateTimeStringDecoding', () {
    final json = '{"time": "2017-02-09T12:05:38.387000+00:00"}';
    final sample = decode<DateTimeTest>(json, DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time,
        equals(DateTime.parse("2017-02-09T12:05:38.387000+00:00")));
  });

  test('dateTimeStringDecodingNull', () {
    final json = '{"time": null}';
    final sample = decode<DateTimeTest>(json, DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time, isNull);
  });

  test('dateTimeStringDecodingWrongFormat', () {
    final json = '{"time": "09/02/2017 00:00"}';
    final sample = decode<DateTimeTest>(json, DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time, isNull);
  });

  test('dateTimeMapDecoding', () {
    final json = '{"time": "2017-02-09T12:05:38.387000+00:00"}';
    final sample = decodeObj<DateTimeTest>(JSON.decode(json), DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time,
        equals(DateTime.parse("2017-02-09T12:05:38.387000+00:00")));
  });

  test('dateTimeEncoding', () {
    final json = '{"time": "2017-02-09T12:05:38.387000+00:00"}';
    final sample = decode<DateTimeTest>(json, DateTimeTest);

    final json2 = encode(sample);
    expect(json2.contains('"time":"2017-02-09T12:05:38.387Z"'), equals(true));
  });
}

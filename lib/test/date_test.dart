import 'package:json_conv/json_conv.dart';
import 'package:test/test.dart';
import 'dart:convert';

class DateTimeTest {
  DateTime time;
}

void main() {
  test('dateTimeStringDecoding', () {
    final json = '{"time": "2017-02-09T12:05:38.387000+00:00"}';
    final sample = decode<DateTimeTest>(json, DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time,
        equals(DateTime.parse("2017-02-09T12:05:38.387000+00:00")));
  });

  test('dateTimeMapDecoding', () {
    final json = '{"time": "2017-02-09T12:05:38.387000+00:00"}';
    final sample = decodeObj<DateTimeTest>(JSON.decode(json), DateTimeTest);

    expect(sample, isNotNull);
    expect(sample.time,
        equals(DateTime.parse("2017-02-09T12:05:38.387000+00:00")));
  });
}

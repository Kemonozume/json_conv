part of test_serialization;

class SimpleClass {
  String helloString = "world";
  int helloInt = 4;
  double helloDouble = 1.2;
  List helloList = [1, 2, "3", 4.0, [5, "6"]];
  Map helloMap = {"foo": "bar"};
}

class NestedClass {
  String this_is_a = "Nested class";
  int blaze = 420;
  SimpleClass nestedSimpleClass = new SimpleClass();
}

serializeObject(x) => god.serialize(x);

testSerializingByReflection() {
  print('Testing serialization by reflection');

  SimpleClass simpleClass = new SimpleClass();
  print('\tSimple class: ${serializeObject(simpleClass)}');

  NestedClass nestedClass = new NestedClass();
  print('\tNested class: ${serializeObject(nestedClass)}');

  print('\n');
}
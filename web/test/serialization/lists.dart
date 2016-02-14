part of test_serialization;

serializeList(List x) => god.serialize(x);

testSerializingLists() {
  print('Testing serialization of lists');

  List emptyList = [];
  print('\tEmpty list: ${serializeList(emptyList)}');

  List<String> primitiveList = ["Hello, world!", 1337, 4.5];
  print('\tList of primitives: ${serializeList(primitiveList)}');

  List mixedList = [1, "thing", {"i don't": "know why"}];
  print('\tMixed list: ${serializeList(mixedList)}');

  List nestedList = ["This is a list", [1, 2, "This is a list within a list", {"woo": ['h', 'o', 'o']}]];
  print('\tNested list: ${serializeList(nestedList)}');

  print('\n');
}
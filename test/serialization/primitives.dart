part of test_serialization;

serializeBool(bool x) => god.serialize(x);

serializeDouble(double x) => god.serialize(x);

serializeNull() => god.serialize(null);

serializeNumber(num x) => god.serialize(x);

testSerializingPrimitives() {
  print('Testing serialization of primitives');
  print('\tserializeNumber(1): ${serializeNumber(1)}');
  print('\tserializeDouble(1.25): ${serializeDouble(1.25)}');
  print('\tserializeBool(true): ${serializeBool(true)}');
  print('\tserializeNull(): ${serializeNull()}');
  print('\n');
}
part of test_serialization;

serializeMap(Map x) => god.serialize(x);

testSerializingMaps() {
  print('Testing serialization of maps');

  Map basicMap = {'hello': 'world'};
  print('\tBasic map: ${serializeMap(basicMap)}');

  Map mixedMap = {'hello': 'world', 'lulz': 1337};
  print('\tMixed map: ${serializeMap(mixedMap)}');

  Map nestedMap = {'hello': 'world', 'map': {'json': 'god', 'version': 1.0}};
  print('\tNested map: ${serializeMap(nestedMap)}');

  print('\n');
}
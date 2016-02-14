import 'serialization/serialization.dart';

main() {
  testSerializingPrimitives();
  testSerializingMaps();
  testSerializingLists();
  testSerializingByReflection();

  print("To test deserialization:");
  print("\t1. pub build");
  print("\t2. npm install -g http-server");
  print("\t3. cd build/web");
  print("\t4. http-server -p 3000");
}
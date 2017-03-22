import 'package:logging/logging.dart';
import 'package:dartson/dartson.dart' as d;

@d.Entity()
class Simple {
  int id;
  String text;

  Simple();

  @override
  String toString() {
    return "$id: $text";
  }
}

@d.Entity()
class Test6 {
  List<Simple> simple;

  Test6();

  @override
  String toString() {
    return simple.fold("Test6: \n", (a, b) => a + b.toString() + "\n");
  }
}

void test<T>(Type i) {
  final Type d = T;
  print(d);
  print(T);
  print(i);
  print("${d == i}");
}

// {: [123]
// }: [125]
// ,: [44]
// [: [91]
// ]: [93]
// ": [34]
//  : 32
// :: 58
void printChars() {
  final l = ["{", "}", ",", "[", "]", '"', ' ', ":", "t", "f", ".", "\n"];
  l.forEach((str) => print("$str: ${str.codeUnits}"));
}

var list =
    '''[{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]},{"simple": [{ "id": 23, "text": "test text" }, { "id": 25, "text": "test text" }, { "id": 26, "text": "test text" }]}]''';

void main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  // final json =
  //     '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
  // final sample = decodeTest<MapComplex>(json, MapComplex);
  // print(sample.persons);

  // int its = 20000;
  // Stopwatch w = new Stopwatch();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = JSON.decode(list);
  // }
  // w.stop();
  // print("JSON.decode took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decode<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 3rd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decodeObj<List<Test6>>(
  //       JSON.decode(list), new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 2nd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = god.deseriaizeJson(list, outputType: new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("json god took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // var dson = new d.Dartson.JSON();
  // for (int i = 0; i < its; i++) {
  //   var b = dson.decode(list, new Test6(), true);
  //   //print(b.length);
  // }
  // w.stop();
  // print("dartson took: ${w.elapsedMilliseconds}");
}

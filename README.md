# json_conv

json_conv started as a fork of [json_god](https://github.com/thosakwe/json_god) to add Annotation Support. 

Most of the source has been rewritten since the initial fork. 

Decoding of json Strings compared to Dartson and json_god: 

```
JSON.decode took: 741ms
json_conv took: 3495ms
json_conv map took: 7583ms
json_god took: 9474ms
dartson took: 42433ms
```


# Installation
    dependencies:
      json_conv: 
        git:
        url: git://github.com/Kemonozume/json_conv.git
        ref: 653b2d2fdb795de933e317cd416b40d1b31902ac


# Usage

```dart
import 'package:json_conv/json_conv.dart'

@Conv()
class ListComplex {
  List<ExtendeeClass> list;
}

@Conv()
class ExtendeeClass {
  int id;
  String text;
}

void main() {
    final json =
              '{"list": [{"id":0, "text":"0"}, {"id":1, "text":"1"},{"id":2, "text":"2"}]}';
    final object = decode(json, ListComplex);
    print(encode(object));
}
```

Check out the Tests to see how to use json_conv. 

## Dart2JS Compatibility
json_conv does not support Transformers for now and you need to use `@MirrorUsed`. 
`@MirrorsUsed` documentation can be found [here](https://api.dartlang.org/1.14.2/dart-mirrors/MirrorsUsed-class.html).

Example on how to use the mirrors import: 

```dart 
@MirrorsUsed(metaTargets: const [Conv])
import 'dart:mirrors';

import 'package:json_conv/json_conv.dart';

@Conv()
class ExtendeeClass {
  int id;
  String text;
}
```

The `@Conv` Annotation is only used to tell mirrors what classes are being used. You only need the `@Conv` Annotation for Dart2JS Compatibility and can safely be omitted if you are using the DartVM. 

## Implementation Annotation 

The `@Implementation` Annotation enables you to use abstract classes in your JSON Data Structure and specify the Implementation of the abstract class with the help of the Annotation. 

```dart
abstract class Person {
  int id;
  String name;
}

@Conv()
class Professor extends Person {
  String faculty;
}

@Conv()
class Response {
  @Implementation(Professor)
  Person person;
}

void main() {
    final json =
            '{"person":{"id": 0, "name":"test professor", "faculty":"test fac"}}';
    final p = decode(json, Response);

    print(p.person.faculty); //prints test fac
}
```

### TypeSeeker Annotation

The `@TypeSeeker` Annotation enables you to specify the Type that should be used mid-parsing. You can specify what JSON Key you want to use to specify the Type of the generated object. 

It is not possible yet to get the entire object. 

```dart
@Conv()
abstract class Channel {
  int id;
  String type;
}

@Conv()
class TextChannel extends Channel {
  String topic;
}

@Conv()
class VoiceChannel extends Channel {
  int bitrate;
}

@Conv()
class ResponseChannel {
  @TypeSeeker("type", seekChannel)
  List<Channel> channel;
}

Type seekChannel(dynamic val) {
  if (val == "text") {
    return TextChannel;
  } else if (val == "voice") {
    return VoiceChannel;
  } else {
    print("unknown type $val");
    return null; //will throw an StateError
  }
}

void main() {
    final json =
        '{"channel": [{"id":0, "type":"text", "topic":"test topic"}, {"id":1, "type":"voice", "bitrate":65000}]}';
    final c = decode(json, ResponseChannel);
}
```

### TypeTransformer interface

The `TypeTransformer<T>` Interface allows you to encode and decode a specific Type how you want. 

```dart 
class _DateTransformer extends TypeTransformer<DateTime> {
  @override
  DateTime decode(dynamic value) {
    try {
      return DateTime.parse(value);
    } catch (e, st) {
      return null;
    }
  }

  @override
  String encode(DateTime value) {
    if (value == null) return "null";
    return value.toIso8601String();
  }
}
```

After creating a TypeTransformer you have to register the Transformer using the function `void registerTransformer(TypeTransformer t, Type type)`.

### Roadmap

 - preserve order of lists
 - transformer for better Dart2JS compatibility
 - better exceptions

### Credits

The TypeTransformer Interface was written by [eredo](https://github.com/eredo).







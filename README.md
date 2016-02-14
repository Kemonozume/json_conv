# JSON God

![version 1.0.0-beta](https://img.shields.io/badge/version-1.0.0%20(beta)-blue.svg)

**NOT YET PRODUCTION READY**

The definitive solution for JSON in Dart.

### Contents

*   [JSON God](#json-god)
*   [About](#about)
*   [Installation](#installation)
*   [Usage](#usage)
    *   [Serializing JSON](#serializing-json)
    *   [Deserializing JSON](#deserializing-json)
        *   [Deserializing to Classes](#deserializing-to-classes)
*   [Compatibility with JsonObject](#compatiblity-with-jsonobject)
    *   [objectToJson](#objecttojson)
    *   [enableJsonObjectDebugMessages](#enablejsonobjectdebugmessages)
*   [Thanks](#thank-you-for-using-jsongod)

# About

I think Dart is really freaking cool, and far better than Javascript. However, coming
from a Javascript background, I really am not a fan of native JSON support only
coming in the form of Maps. What about classes? What if I want to serialize my
precious objects? What if I want to validate JSON input?

My main problem with Dart is that it does not natively support this. And the
standard [JsonObject Library](https://github.com/chrisbu/dartwatch-JsonObject)
is outdated and incompatible with SDK 1.0+.

To remedy this, I wrote JSON God. JSON God exposes a class called God.
God contains just two methods: *serialize* and *deserialize*. You can call these
synchronously, and **even in the browser**. Cool, right?

I made a few provisions for compatibility with JsonObject, too.

**Bow down to JSON God.**

# Installation

To install JSON God for your Dart project, simply add json_god to your
pub dependencies. If you use an old version of the SDK (<1.0), stick with
JsonObject.

    dependencies:
        json_god: any

I do not plan any major changes to the API, and future releases will be, for the
most part, backwards-compatible. However, if you are paranoid, apply the version
constraint `'^1.0.0'` instead of `'any'`.

# Usage

Serialization and deserialization are run through the `God` class. Instantiate a new
`God` to begin.

```dart
import 'package:json_god/json_god.dart';

God god = new God();

// Set .debug to true to print debug output.
// CAUTION: It is very verbose.
// god.debug = true;
```

**IMPORTANT - Reflection through dart:mirrors is not yet perfect in Dart2JS. Make sure
to add a `@MirrorsUsed()` annotation to any classes you want to serialize/deserialize.**

```dart
library app;

@MirrorsUsed(targets: 'app')
import 'dart:mirrors';
```

`@MirrorUsed` documentation can be found [here](https://api.dartlang.org/1.14.2/dart-mirrors/MirrorsUsed-class.html).

## Serializing JSON

Simply call `god.serialize(x)` to synchronously transform an object into a JSON
string.
```dart
Map map = {"foo": "bar", "numbers": [1, 2, {"three": 4}]};

// Output: {"foo":"bar","numbers":[1,2,{"three":4]"}
String json = god.serialize(map);
print(json);
```

You can easily serialize classes, too. JSON God also supports classes as members.
```dart
class A {
    String foo;
    A(this.foo);
}

class B {
    String hello;
    A nested;
    B(String hello, String foo) {
      this.hello = hello;
      this.nested = new A(foo);
    }
}

main() {
    God god = new God();
    print(god.serialize(new B("world", "bar")));
}

// Output: {"hello":"world","nested":{"foo":"bar"}}
```

## Deserializing JSON

Deserialization is equally easy, and is provided through `god.deserialize`.
```dart
Map map = god.deserialize('{"hello":"world"}');
int three = god.deserialize("3");
```

### Deserializing to Classes

JSON God lets you deserialize JSON into an instance of any type. Simply pass the
type as the second argument to `god.deserialize`.

```dart
class Child {
  String foo;
}

class Parent {
  String hello;
  Child child = new Child();
}

main() {
  God god = new God();
  Parent parent = god.deserialize('{"hello":"world","child":{"foo":"bar"}}', Parent);
  print(parent);
}
```

**Any JSON-deserializable classes must initializable without parameters.
If `new Foo()` would throw an error, then you can't use Foo with JSON.**

This allows for validation of a sort, as only fields you have declared will be
accepted.

```dart
class HasAnInt { int theInt; }

HasAnInt invalid = god.deserialize('["some invalid input"]', HasAnInt);
// Throws a NoSuchMethodError
```

# Compatiblity with JsonObject

As mentioned before, there is some compatibility with JsonObject for projects that
already use that library.

## objectToJson

JsonObject, as I said before, is old, and uses the older `Future` API. It exposes
a `Future<String>` called `objectToJson` that serializes an object. I felt like this
was worth keeping, so I kept it.

```dart
main() async {
    Map map = {"hello": "world"};

    // Using await
    String json = await objectToJson(map);

    // Using Future.then
    objectToJson(map).then(print);
}
```

It's marked as deprecated, because with JSON God you really should just stick with
`god.serialize`.

## enableJsonObjectDebugMessages

This boolean flag is used internally by the God class, and is the equivalent of
`god.debug`.

# Thank you for using JSON God

Thank you for using this library. I hope you like it.

Feel free to follow me on Twitter:

[@thosakwe](http://twitter.com/thosakwe)
or
[@bazangtech](http://twitter.com/bazangtech)
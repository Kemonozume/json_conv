# JSON God v2

![version 2.0.0-beta](https://img.shields.io/badge/version-2.0.0--beta-blue.svg)

The ***new and improved*** definitive solution for JSON in Dart.


# Installation
    dependencies:
        json_god: ^2.0.0-beta

# Usage

It is recommended to import the library under an alias, i.e., `god`.

```dart
import 'package:json_god/json_god.dart' as god;

// Set .debug to true to print VERY VERBOSE debug output.
// god.debug = true;
```

## Dart2JS Compatibility
**IMPORTANT - Reflection through dart:mirrors is not yet perfect in Dart2JS. Make sure
to add a `@MirrorsUsed()` annotation to any classes you want to serialize/deserialize.**

```dart
library app;

@MirrorsUsed(targets: 'app')
import 'dart:mirrors';
```

`@MirrorsUsed` documentation can be found [here](https://api.dartlang.org/1.14.2/dart-mirrors/MirrorsUsed-class.html).

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

If a class has a `toJson` method, it will be called instead.

## Deserializing JSON

Deserialization is equally easy, and is provided through `god.deserialize`.
```dart
Map map = god.deserialize('{"hello":"world"}');
int three = god.deserialize("3");
```

### Deserializing to Classes

JSON God lets you deserialize JSON into an instance of any type. Simply pass the
type as the second argument to `god.deserialize`.

If the class has a `fromJson` constructor, it will be called instead.

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
// Throws an error
```

# Validation
You can also enforce validation rules, thanks to the `json_schema` package.
Both `serialize` and `deserialize` support a named parameter, `schema`. Alternatively,
use the `WithSchema` or `WithSchemaUrl` annotations on your classes.

```dart
@WithSchema(const {})

@WithSchemaUrl("url")
```

An exception will be thrown if validation fails.

# Thank you for using JSON God

Thank you for using this library. I hope you like it.

Feel free to follow me on Twitter: 
[@thosakwe](http://twitter.com/thosakwe)

Or, check out [my blog](http://blog.thosakwe.com)
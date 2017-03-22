# json_conv

json_conv started as a fork of [json_god](https://github.com/thosakwe/json_god) to add Annotation Support. 

Most of the source code has been rewritten since then. json_conv focuses on Speed and does not support encoding for now. 

Decoding of json Strings compared to Dartson and json_god:
JSON.decode took: 741ms
json_conv took: 3495ms
json_conv map took: 7583ms
json_god took: 9474ms
dartson took: 42433ms



# Installation
    dependencies:
      json_conv: 
        git:
        url: git://github.com/Kemonozume/json_conv.git
        ref: 91460620483295f31fecb0b1d6496ef347a2b21f


# Usage

Check out the Tests to see how to use json_conv. 

## Dart2JS Compatibility
json_conv does not support Transformers for now and you need to use `@MirrorUsed`. 
`@MirrorsUsed` documentation can be found [here](https://api.dartlang.org/1.14.2/dart-mirrors/MirrorsUsed-class.html).

## FIXME ;)

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


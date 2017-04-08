part of json_conv;

/// Annotation class to describe properties of a class member.
/// taken from Dartson
class Property {
  final bool _ignore;
  final String name;

  const Property({bool ignore, String name})
      : this._ignore = ignore,
        this.name = name;

  bool get ignore => _ignore == null ? false : _ignore;
}

/// TypeFinder is a function that has to return the wanted type
/// using the key and val to determine the wanted type
typedef Type TypeFinder(dynamic val);

class TypeSeeker {
  final String key;
  final TypeFinder finder;

  const TypeSeeker(this.key, this.finder);
}

class Implementation {
  final Type type;

  const Implementation(this.type);
}

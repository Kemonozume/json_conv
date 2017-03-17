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
  bool get hasName => (name == null) ? false : (name.isEmpty) ? false : true;
}

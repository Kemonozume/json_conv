class ExtendeeClass {
  int id;
  String text;
}

class ExtenderClass extends ExtendeeClass {
  bool isValid;
}

class ListSimple {
  List<String> list;
}

class ListComplex {
  List<ExtendeeClass> list;
}

class MapComplex {
  Map<String, Person> persons;
}

class MapSimple {
  Map<String, String> persons;
}

class Person {
  String name;
}

class Male {
  Person person;
  String test;
}

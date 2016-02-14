library app;

import 'dart:html';

import '../test/serialization/serialization.dart';
@MirrorsUsed(targets: 'app, test_serialization')
import 'dart:mirrors';

class Todo {
  int id;
  String text;
}

class TodoList {
  List<Todo> todos;
}

main() {
  god
    ..debug = window.confirm(
        'Press OK to enable debug output in the console.\n\n'
            'Be warned: It can be verbose!\nHowever, for testing purposes, this is a good thing.');
  print(god.debug
      ? "Enabled JSON God debug logging."
      : "Debug logging is disabled. In case of error, please enable it.");
  //Tests in console
  testSerializingPrimitives();
  testSerializingMaps();
  testSerializingLists();
  testSerializingByReflection();
  querySelector('#serialization').text = 'Serialization Tests Complete';
  querySelector('#deserialization').text = 'Running Deserialization Tests...';

  testDeserialization();
}

testDeserialization() {
  bool result = deserializeSimple() && deserializeComplex();

  if (result) querySelector('#deserialization').text =
  "All Deserialization Tests Successful";
  else querySelector('#deserialization').text =
  "One or more deserialization tests failed. Check the log for more information.";
}

bool deserializeSimple() {
  Todo todo = god.deserialize('{"id": 1337, "text": "lulz"}', Todo);
  if (todo.id == 1337 && todo.text == "lulz") {
    print("Deserialization of simple objects: [YES]");
    return true;
  } else {
    window.console.error("Deserialization of simple objects: [NO]");
    return false;
  }
}

bool deserializeComplex() {
  TodoList todoList = god.deserialize(
      '{"todos":[{"id": 1337, "text": "lulz"}, {"id": 1975, "text": "ugh"}]}',
      TodoList);
  if (todoList.todos.length == 2
      && todoList.todos[0].id == 1337 && todoList.todos[0].text == "lulz"
      && todoList.todos[1].id == 1975 && todoList.todos[1].text == "ugh") {
    print("Deserialization of complex objects: [YES]");
    return true;
  } else {
    window.console.error("Deserialization of complex objects: [NO]");
    return false;
  }
}
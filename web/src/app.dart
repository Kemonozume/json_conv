import 'dart:html';

import '../packages/json_god/json_god.dart';
//import 'package:json_god/json_god.dart';

God god = new God();

class Todo {
  int id;
  String text;
}

class TodoList {
  List<Todo> todos;
}

main() {
  bool result = deserializeSimple() && deserializeComplex();

  if (result) window.alert("All tests were successful.");
  else window.alert(
      "One or more tests failed. Check the log for more information.");
}

bool deserializeSimple() {
  Todo todo = god.deserialize('{"id": 1337, "text": "lulz"}', Todo);
  if (todo.id == 1337 && todo.text == "lulz") {
    print("Deserialization of simple objects: [YES]");
    return true;
  } else {
    print("Deserialization of simple objects: [NO]");
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
    print("Deserialization of complex objects: [NO]");
    return false;
  }
}
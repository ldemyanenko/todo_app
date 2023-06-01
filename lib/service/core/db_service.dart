

import 'package:todo_app/model/todo.dart';

abstract class DBService {

  Future init();

  Iterable<Todo> readAllTodo();

  void saveTodo(Todo todo);

  Future clearDb();

  void updateTodos(Map<int, Todo> todos);


  }
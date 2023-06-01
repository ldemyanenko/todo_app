
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/db_service.dart';

class MockEmptyDBService extends DBService{


  @override
  Future clearDb() async {
  return;
  }

  @override
  Future init() async {
    return;
  }

  @override
  Iterable<Todo> readAllTodo() {
    return [];
  }

  @override
  saveTodo(Todo todo) {

  }

  @override
  updateTodos(Map<int, Todo> todos) {
  }

}
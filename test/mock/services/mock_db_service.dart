
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/db_service.dart';

class MockDBService extends DBService{
  static const userId = 1234;
  static const id = 1;

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
    return [const Todo(userId: userId, id: id, title: "Test TODO", completed: false)];
  }

  @override
  saveTodo(Todo todo) {
  }

  @override
  updateTodos(Map<int, Todo> todos) {
  }

}
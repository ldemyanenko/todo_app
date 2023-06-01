import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/db_service.dart';

class HiveService extends DBService {
  late Box<Todo> _box;

  Future init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(TodoAdapter());

    _box = await Hive.openBox<Todo>("_hive_todo_box");
  }

  @override
  Iterable<Todo> readAllTodo() {
    log("read from DB ${_box.values.length}");
    return _box.values;
  }

  @override
  Future clearDb() async {
    await Hive.deleteFromDisk();
  }

  @override
  saveTodo(Todo todo) async {
    _box.put(todo.id, todo);
  }

  @override
  Future updateTodos(Map<int, Todo> todos) async {
    log("write to DB ${todos.length}");
    await _box.putAll(todos);
    _box.flush();
  }
}

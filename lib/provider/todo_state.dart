import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/api_service.dart';
import 'package:todo_app/service/core/auth_service.dart';
import 'package:todo_app/service/core/db_service.dart';
import 'package:todo_app/service/service_locator.dart';

class TodoState extends ChangeNotifier {
  TodoState() {
    init();
  }

  final ApiService _apiService = locator<ApiService>();
  final DBService _dbService = locator<DBService>();
  final AuthService _authService = locator<AuthService>();

  bool isTodoLoading = false;

  List<Todo>? todoItems = [];

  Future init() async {
    await fetchTodoList();
  }

  Future fetchTodoList() async {
    isTodoLoading = true;
    notifyListeners();
    var dbResults = _dbService.readAllTodo();
    if (dbResults.isNotEmpty) {
      todoItems = dbResults.toList().reversed.toList(); // using reversed to reverse order in the list for storing
    } else {
      var apiResults = await _apiService.fetchTodoListItems();
      if (apiResults != null) {
        var filteredTodos = apiResults.where((element) => element.userId == _authService.userId);
        todoItems = filteredTodos.toList().reversed.toList();
        _dbService.updateTodos(Map.fromEntries(filteredTodos.toList().map((e) => MapEntry(e.id, e)))); // using reverse to reverse order in the list so we could add new item in the end and see it on top
      }
    }
    isTodoLoading = false;
    notifyListeners();
  }

  void addNewTodo({required String text}) {
    var todo = Todo(
        userId: _authService.userId,
        id: (todoItems?.map((e) => e.id).reduce(max) ?? 0) + 1, // id generation should come from endpoint for adding new item
        title: text,
        completed: false);
    _dbService.saveTodo(todo);
    todoItems?.insert(0, todo); // empty todoItems would be an error state so we don't have to handle it
  }
}

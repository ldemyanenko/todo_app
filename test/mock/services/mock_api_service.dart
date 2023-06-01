

import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/api_service.dart';

class MockApiService extends ApiService{
  static const id = 99999;

  final int userId;

  MockApiService({required this.userId});

  @override
  Future<List<Todo>?> fetchTodoListItems() async{
    await Future.delayed(const Duration(seconds: 1));
    return [ Todo(userId: userId, id: id, title: "Test TODO", completed: false)];
  }

}
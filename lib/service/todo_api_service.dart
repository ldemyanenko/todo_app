import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/core/api_service.dart';

class TodoApiService extends ApiService {
  final dio = Dio();

  @override
  Future<List<Todo>?> fetchTodoListItems() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/todos');
    log("fetch from API ${response.data?.length}");

    return response.data == null ? null : List.from(response.data.map((e) => Todo.fromJson(e)));
  }
}

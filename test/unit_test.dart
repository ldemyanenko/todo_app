
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/provider/todo_state.dart';
import 'package:todo_app/service/core/api_service.dart';
import 'package:todo_app/service/core/auth_service.dart';
import 'package:todo_app/service/core/db_service.dart';
import 'package:todo_app/service/service_locator.dart';
import 'package:todo_app/service/simple_auth_service.dart';

import 'mock/services/mock_api_service.dart';
import 'mock/services/mock_db_service.dart';
import 'mock/services/mock_empty_db_service.dart';

void main() {
  locator.allowReassignment = true; // used for reassigning get it singletons during the tests
  locator.registerLazySingleton<AuthService>(() => SimpleAuthService());
  locator.registerLazySingleton<ApiService>(() => MockApiService(userId: locator<AuthService>().userId));

  group('TodoState checks', () {
    test('Check todo fetch on state creation when db is empty', () async {
      locator.registerLazySingleton<DBService>(() => MockEmptyDBService());

      var todoState = TodoState();
      expect(todoState.isTodoLoading, true);
      await Future.delayed(const Duration(milliseconds: 1100)); // more than mock fetchTodo call takes
      expect(todoState.isTodoLoading, false);
      expect(todoState.todoItems?.isNotEmpty, true);
      expect(todoState.todoItems?.first.id, MockApiService.id);

    });

    test('Check todo fetch user filtering', () async {
      locator.registerLazySingleton<ApiService>(() => MockApiService(userId: 1234));
      locator.registerLazySingleton<DBService>(() => MockEmptyDBService());

      var todoState = TodoState();
      expect(todoState.isTodoLoading, true);
      await Future.delayed(const Duration(milliseconds: 1100)); // more than mock fetchTodo call takes
      expect(todoState.isTodoLoading, false);
      expect(todoState.todoItems?.isNotEmpty, false); // it should be empty as we used different from current user id in MockApiService
    });

    test('Check todo fetch on state creation when db is not empty', () async {
      locator.registerLazySingleton<DBService>(() => MockDBService());

      var todoState = TodoState();
      expect(todoState.isTodoLoading, false);
      expect(todoState.todoItems?.isNotEmpty, true);
      expect(todoState.todoItems?.first.id, MockDBService.id);
    });

    test('Check add new todo feature', () async {
      locator.registerLazySingleton<DBService>(() => MockDBService());

      var todoState = TodoState();
      expect(todoState.todoItems?.length, 1); // there is one item  from DB
      todoState.addNewTodo(text: "Test todo");
      expect(todoState.todoItems?.length, 2);

    });
   });



}
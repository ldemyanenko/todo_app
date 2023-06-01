import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app.dart';

import 'package:todo_app/service/core/api_service.dart';
import 'package:todo_app/service/core/auth_service.dart';
import 'package:todo_app/service/core/db_service.dart';
import 'package:todo_app/service/service_locator.dart';
import 'package:todo_app/service/simple_auth_service.dart';
import 'package:todo_app/ui/item/todo_list_item.dart';
import 'package:todo_app/ui/page/add_todo_page.dart';

import 'mock/services/mock_api_service.dart';
import 'mock/services/mock_empty_db_service.dart';

void main() {
  locator.registerLazySingleton<AuthService>(() => SimpleAuthService());
  locator.registerLazySingleton<ApiService>(() => MockApiService(userId: locator<AuthService>().userId));
  locator.registerLazySingleton<DBService>(() => MockEmptyDBService());

  testWidgets('Check Todo List page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TodoApp());
    // only for case of empty db there will be a loader
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1100));
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // check that TodoListItem appears
    expect(find.byType(TodoListItem), findsOneWidget);
  });

  testWidgets('Check Add Todo page', (WidgetTester tester) async {
    // setup a home page as AddTodoPage
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const AddTodoPage();
          },
        ),
      ],
    );
    await tester.pumpWidget(TodoApp(routerConfig: router));
    expect(find.byType(TextField), findsOneWidget);
    var field = find.byType(TextField);
    await tester.enterText(field, 'Test TODO');
    await tester.pump(const Duration(milliseconds: 1000));

    expect(find.byType(ElevatedButton), findsOneWidget); // check main button is there
  });
}

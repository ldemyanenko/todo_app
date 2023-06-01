import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/page/add_todo_page.dart';
import 'package:todo_app/ui/page/todo_list_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoListPage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "add_todo",
          path: 'add_todo',
          builder: (BuildContext context, GoRouterState state) {
            return const AddTodoPage();
          },
        ),
      ],
    ),
  ],
);

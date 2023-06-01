import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_state.dart';
import 'package:todo_app/router.dart';

class TodoApp extends StatelessWidget {
  final RouterConfig<Object>? routerConfig;
  const TodoApp({super.key, this.routerConfig});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoState>(
      create: (BuildContext context) => TodoState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Todo app',
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.grey.withAlpha(100), textTheme: const TextTheme(subtitle1: TextStyle(fontSize: 14))),
        routerConfig: routerConfig ?? router,
      ),
    );
  }
}

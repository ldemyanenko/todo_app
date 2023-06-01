import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/service/core/db_service.dart';
import 'package:todo_app/service/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await locator<DBService>().init();
  runApp(const TodoApp());
}






import 'package:get_it/get_it.dart';
import 'package:todo_app/service/core/api_service.dart';
import 'package:todo_app/service/core/auth_service.dart';
import 'package:todo_app/service/core/db_service.dart';
import 'package:todo_app/service/hive_service.dart';
import 'package:todo_app/service/simple_auth_service.dart';
import 'package:todo_app/service/todo_api_service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<ApiService>(() => TodoApiService());
  locator.registerLazySingleton<DBService>(() => HiveService());
  locator.registerLazySingleton<AuthService>(() => SimpleAuthService());

}
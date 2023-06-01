

import 'package:todo_app/service/core/auth_service.dart';

class SimpleAuthService  extends AuthService{
  @override
  int get userId => 1;  // this mock authentication service and returns user id for the current authenticated user

}
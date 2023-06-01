
import 'package:todo_app/model/todo.dart';

abstract class  ApiService {


  Future<List<Todo>?> fetchTodoListItems();
}
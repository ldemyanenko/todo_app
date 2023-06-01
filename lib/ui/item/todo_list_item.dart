import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      contentPadding: const EdgeInsets.all(8),
      tileColor: Theme.of(context).backgroundColor,
      title: Text(todo.title),
      trailing: todo.completed ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
    );
  }
}

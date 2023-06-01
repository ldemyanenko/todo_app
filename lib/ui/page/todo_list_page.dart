import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/localisation.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todo_state.dart';
import 'package:todo_app/ui/item/todo_list_item.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var todoListItems = Provider.of<TodoState>(context).todoItems;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                'add_todo',
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text(AppLocalisation.todoListPageTitle),
      ),
      body: _buildContent(context, todos: todoListItems),
    );
  }

  Widget _buildContent(BuildContext context, {List<Todo>? todos}) {
    if (todos == null) {
      return const Center(
        child: Text(AppLocalisation.todoListPageErrorText),
      );
    }

    if (Provider.of<TodoState>(context).isTodoLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 8,
        );
      },
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return TodoListItem(todo: todos[index]);
      },
    );
  }
}

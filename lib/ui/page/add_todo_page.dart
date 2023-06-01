

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/localisation.dart';
import 'package:todo_app/provider/todo_state.dart';

class AddTodoPage extends HookWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var textController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLocalisation.addTodoPageTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppLocalisation.addTodoPageTextFieldHint
          ),
          controller: textController,
        ),
        const Spacer(),
        ElevatedButton(
            onPressed: (){
              var text = textController.text;
              Provider.of<TodoState>(context, listen: false).addNewTodo(text: text);
              context.pop();
        }, child: const Text( AppLocalisation.addTodoPageMainButtonTitle)),
        const SizedBox(height: 32,),
      ],),
      )
    );
  }
}

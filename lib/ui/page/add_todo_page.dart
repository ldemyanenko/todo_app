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
    // a way to use a text controller and sored variable with flutter hooks avoiding Statefull widget, make the code more easily reusable and allows to keep const widget
    final textController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, [key]);

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppLocalisation.addTodoPageTitle),
        ),
        body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return AppLocalisation.addTodoPageTextFieldValidationError;
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: const InputDecoration(hintText: AppLocalisation.addTodoPageTextFieldHint),
                  controller: textController,
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        var text = textController.text;
                        Provider.of<TodoState>(context, listen: false).addNewTodo(text: text);
                        context.pop();
                      }
                    },
                    child: const Text(AppLocalisation.addTodoPageMainButtonTitle)),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ));
  }
}

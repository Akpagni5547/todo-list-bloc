import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_event.dart';

import '../models/todo.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleTodo = TextEditingController();
    TextEditingController descriptionTodo = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: titleTodo,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0)),
                    hintText: 'Ajouter le titre'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionTodo,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0)),
                    hintText: 'Ajouter la description'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(TodoAdd(
                            todo: Todo(
                                title: titleTodo.text,
                                descriptiom: descriptionTodo.text,
                                isCompleted: false,
                                id: uuid.v4())));
                        Navigator.pop(context);
                      },
                      child: const Text('Ajouter'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_bloc.dart';

class StatTodoPage extends StatelessWidget {
  const StatTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String markAllCompleted = 'MarkAllCompleted';
    String deleteAllCompleted = 'DeleteAllCompleted';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter todos'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              // initialValue: deleteAllCompleted,
                onSelected: (String onSelected) {
                  if (onSelected == markAllCompleted) {
                    // context.read<TodosCubit>().markAllTodoCompleted();
                  } else {
                    // context.read<TodosCubit>().deleteAllTodoCompleted();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: markAllCompleted,
                    child: const Text('Marquez tous finis'),
                  ),
                  PopupMenuItem(
                      value: deleteAllCompleted,
                      child: const Text('Supprimez tous les todos finis'))
                ],
                child: const Icon(Icons.more_horiz)),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              final listTodo = context.select((TodoBloc bloc){
                  var todoCompleted =
                      bloc.state.where((element) => element.isCompleted == true).length;
                  var todoNoCompleted =
                      bloc.state.where((element) => element.isCompleted == false).length;
                  return {"completed": todoCompleted, "inCompleted": todoNoCompleted};
              });
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Todo non fini :',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(listTodo['inCompleted'].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Todo fini :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(listTodo['completed'].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

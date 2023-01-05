import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/filter_todo_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/todo_bloc/screens/add_todo.dart';
import 'package:todo_bloc/todo_bloc/screens/detail_todo.dart';

import '../models/todo.dart';

class ListTodoPage extends StatelessWidget  {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String markAllCompleted = 'MarkAllCompleted';
    String deleteAllCompleted = 'DeleteAllCompleted';
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    FilterTodo filter = context.watch<FilterTodoBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter todos'),
        centerTitle: false,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton(
                initialValue: filter,
                onSelected: (FilterTodo onSelected) {
                  if (onSelected == FilterTodo.allTodo) {
                    context.read<FilterTodoBloc>().add(FilterTodoAll());
                  } else if (onSelected == FilterTodo.completedTodo) {
                    context.read<FilterTodoBloc>().add(FilterTodoCompleted());
                  } else {
                    context.read<FilterTodoBloc>().add(FilterTodoNoCompleted());
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: FilterTodo.allTodo,
                    child: Text('Show all todo'),
                  ),
                  const PopupMenuItem(
                      value: FilterTodo.completedTodo,
                      child: Text('Show todo completed')),
                  const PopupMenuItem(
                      value: FilterTodo.noCompletedTodo,
                      child: Text('Show todo no completed'))
                ],
                child: const Icon(Icons.filter_list),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                // initialValue: deleteAllCompleted,
                onSelected: (String onSelected) {
                  if (onSelected == markAllCompleted) {
                    context.read<TodoBloc>().add(TodoMarkAll());
                  } else {
                    context.read<TodoBloc>().add(TodoDeleteCompleted());
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: todoBloc,
                        child: const AddTodoPage(),
                      )));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Builder(builder: (context) {
            final listTodos = context.watch<TodoBloc>().state;
            final List<Todo> listTodoFiltered = listTodos.where((element) {
              if (filter == FilterTodo.allTodo) {
                return true;
              } else if (filter == FilterTodo.completedTodo) {
                return element.isCompleted == true;
              } else {
                return element.isCompleted == false;
              }
            }).toList();
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: listTodoFiltered.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: ValueKey<String>(listTodoFiltered[index].id),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.redAccent,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      context
                          .read<TodoBloc>()
                          .add(TodoDelete(id: listTodoFiltered[index].id));
                    },
                    child: ListTile(
                      title: Text(listTodoFiltered[index].title,
                          style: TextStyle(
                              decoration: listTodoFiltered[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                      subtitle: Text(listTodoFiltered[index].descriptiom,
                          style: TextStyle(
                              decoration: listTodoFiltered[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                    value: todoBloc,
                                    child: DetailTodoPage(
                                      todo: listTodoFiltered[index],
                                    ))));
                      },
                      leading: Checkbox(
                        value: listTodoFiltered[index].isCompleted,
                        onChanged: (bool? value) {
                          context
                              .read<TodoBloc>()
                              .add(TodoCheck(id: listTodoFiltered[index].id));
                        },
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
              ),
            );
          }),
        ),
      ),
    );
  }
}

import 'package:todo_bloc/todo_bloc/models/todo.dart';

abstract class TodoEvent {}

class TodoAdd extends TodoEvent {
  final Todo todo;
  TodoAdd({required this.todo});
}

class TodoDelete extends TodoEvent {
  final String id;
  TodoDelete({required this.id});
}

class TodoUpdate extends TodoEvent {
  final Todo todo;
  TodoUpdate({required this.todo});
}

class TodoCheck extends TodoEvent {
  final String id;
  TodoCheck({required this.id});
}

class TodoMarkAll extends TodoEvent {}

class TodoDeleteCompleted extends TodoEvent {}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/todo_bloc/models/todo.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class TodoBloc extends Bloc<TodoEvent, List<Todo>>{
  TodoBloc(): super([
      Todo(id: uuid.v4(), title: 'Manger', isCompleted: false, descriptiom: 'Le faire dans la soireée'),
      Todo(id: uuid.v4(), title: 'Dormir', isCompleted: false, descriptiom: 'Le faire dans la journée'),
      Todo(id: uuid.v4(), title: 'Travailler', isCompleted: true, descriptiom: 'Le faire dans l\'après midi'),
      Todo(id: uuid.v4(), title: 'Sauter', isCompleted: false, descriptiom: 'Le faire dans la nuit tard apres les gougnons'),
  ]) {
    on<TodoCheck>((event, emit){
      var todos = [...state];
      var indexTodo = todos.indexWhere((element) => element.id == event.id);
      todos[indexTodo].isCompleted = !todos[indexTodo].isCompleted;
      emit(todos);
    });
    on<TodoAdd>((event, emit){
      var todos = [...state, event.todo];
      emit(todos);
    });

    on<TodoUpdate>((TodoUpdate event, emit){
      var todos = [...state];
      var indexTodo = todos.indexWhere((element) => element.id == event.todo.id);
      todos[indexTodo] = Todo(title: event.todo.title, descriptiom: event.todo.descriptiom, isCompleted: event.todo.isCompleted, id: event.todo.id);
      emit(todos);
    });

    on<TodoMarkAll>((event, emit){
      var todos = [...state];
      List<Todo> todosMarked = [];
      for (var todo in todos){
        todosMarked.add(Todo(title: todo.title, descriptiom: todo.descriptiom, isCompleted: true, id: todo.id));
      }
      emit(todosMarked);
    });

    on<TodoDeleteCompleted>((event, emit){
      var todos = [...state];
      List<Todo> deleteTodoCompleted = todos.where((element) => element.isCompleted == false).toList();
      emit(deleteTodoCompleted);
    });

    on<TodoDelete>((event, emit){
      var todos = [...state];
      var indexTodo = todos.indexWhere((element) => element.id == event.id);
      todos.removeAt(indexTodo);
      emit(todos);
    });
  }
}
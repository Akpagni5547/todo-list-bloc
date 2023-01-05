import 'package:flutter_bloc/flutter_bloc.dart';

enum FilterTodo { allTodo, completedTodo, noCompletedTodo }


abstract class FilterEvent {}

class FilterTodoAll extends FilterEvent {}
class FilterTodoCompleted extends FilterEvent {}
class FilterTodoNoCompleted extends FilterEvent {}

class FilterTodoBloc extends Bloc<FilterEvent, FilterTodo> {
  FilterTodoBloc() : super(FilterTodo.allTodo) {
    on<FilterTodoAll>((event, emit){
      emit(FilterTodo.allTodo);
    });

    on<FilterTodoCompleted>((event, emit){
      emit(FilterTodo.completedTodo);
    });

    on<FilterTodoNoCompleted>((event, emit){
      emit(FilterTodo.noCompletedTodo);
    });
  }


}
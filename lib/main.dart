import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/counter_bloc/bloc/counter_bloc.dart';
import 'package:todo_bloc/counter_bloc/screens/counter.dart';
import 'package:todo_bloc/todo_bloc/bloc/filter_todo_bloc.dart';
import 'package:todo_bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_bloc/screens/home_todo.dart';
import 'package:todo_bloc/todo_bloc/screens/list_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CounterBloc(),
          ),
          BlocProvider(
            create: (_) => TodoBloc(),
            // child: const ListTodoPage(),
          ),
          BlocProvider(create: (_) => FilterTodoBloc())
        ],
        child: const HomePage(),
      ),
    );
  }
}

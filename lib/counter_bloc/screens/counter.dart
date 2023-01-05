import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/counter_bloc/bloc/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter page avec bloc'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
            backgroundColor: Colors.grey,
            // foregroundColor: Colors.amber,
            // hoverColor: Colors.cyan,
            // focusColor: Colors.deepOrange,
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressed());
            },
            backgroundColor: Colors.grey,
            // foregroundColor: Colors.amber,
            // hoverColor: Colors.cyan,
            // focusColor: Colors.deepOrange,
            child: const Icon(Icons.remove),
          )
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            final state = context.watch<CounterBloc>().state;
            return Center(
              child: Text(
                state.toString(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}

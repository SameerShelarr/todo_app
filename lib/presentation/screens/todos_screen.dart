import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          Tooltip(
            message: "Add Todo",
            child: InkWell(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.add),
              ),
              onTap: () => Navigator.pushNamed(context, addTodoRoute),
            ),
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          return BlocBuilder<TodosCubit, TodosState>(
            builder: (context, state) {
              return BlocBuilder<TodosCubit, TodosState>(
                builder: (context, state) {
                  Future.delayed(
                    const Duration(seconds: 3),
                  );
                  if (state is! TodosLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final todos = (state).todos;
                  return SingleChildScrollView(
                    child: Column(
                      children:
                          todos.map((e) => _addTodos(e, context)).toList(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _addTodos(Todo todo, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, editTodoRoute, arguments: todo),
      child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoUi(todo, context),
        background: Container(
          color: todo.isComplete ? Colors.red : Colors.green,
        ),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
      ),
    );
  }

  _completionIndicator(Todo todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
              width: 4.0, color: todo.isComplete ? Colors.green : Colors.red)),
    );
  }

  _todoUi(Todo todo, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }
}

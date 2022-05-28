import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  final _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
          actions: [
            BlocBuilder<AddTodoCubit, AddTodoState>(
              builder: (context, state) {
                if (state is AddingTodo) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Tooltip(
                  message: "Done",
                  child: InkWell(
                    onTap: () {
                      final message = _todoTextController.text;
                      BlocProvider.of<AddTodoCubit>(context).addTodo(message);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.done,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is TodoAdded) {
              Navigator.pop(context);
            } else if (state is AddTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: _body(context),
          ),
        )
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _todoTextController,
          decoration: const InputDecoration(
              hintText: "Enter the todo..."
          ),
        )
      ],
    );
  }
}

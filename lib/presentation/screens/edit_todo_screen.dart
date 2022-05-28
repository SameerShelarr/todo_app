import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;
  final _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _todoTextController.text = todo.todoMessage;
    return BlocBuilder<EditTodoCubit, EditTodoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Todo"),
            actions: [_showActions(context, state)],
          ),
          body: BlocListener<EditTodoCubit, EditTodoState>(
            listener: (context, state) {
              if (state is EditTodoSuccessful) {
                Navigator.pop(context);
              } else if (state is EditTodoError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: _body(context),
              ),
            ),
          ),
        );
      },
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _todoTextController,
          decoration: const InputDecoration(hintText: "Enter the todo..."),
        )
      ],
    );
  }

  _showLoader() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  _deleteAction(BuildContext context) {
    return Tooltip(
      message: "Delete",
      child: InkWell(
        onTap: () {
          BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete),
        ),
      ),
    );
  }

  _saveAction(BuildContext context) {
    return Tooltip(
      message: "Save ",
      child: InkWell(
        onTap: () {
          BlocProvider.of<EditTodoCubit>(context)
              .updateTodo(todo, _todoTextController.text);
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.done),
        ),
      ),
    );
  }

  _showActions(BuildContext context, EditTodoState state) {
    if (state is EditingTodo) {
      return _showLoader();
    } else {
      return _actions(context);
    }
  }

  _actions(BuildContext context) {
    return Row(
      children: [
        _deleteAction(context),
        _saveAction(context),
      ],
    );
  }
}

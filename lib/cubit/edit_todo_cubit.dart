import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());

  final Repository repository;
  final TodosCubit todosCubit;

  void deleteTodo(Todo todo) {
    emit(EditingTodo());
    Future.delayed(const Duration(seconds: 3), () {
      repository.deleteTodo(todo.id).then((isDeleted) {
        if (isDeleted) {
          todosCubit.deleteTodo(todo);
          emit(EditTodoSuccessful());
        } else {
          emit(EditTodoError(errorMessage: "Failed to delete the todo"));
        }
      });
    });
  }

  void updateTodo(Todo todo, String text) {
    emit(EditingTodo());
    if (text.isEmpty) {
      emit(EditTodoError(errorMessage: "The todo text cant be empty"));
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        repository.updateTodo(todo.id, text).then((isUpdated) {
          if (isUpdated) {
            todo.todoMessage = text;
            todosCubit.updateTodosList();
            emit(EditTodoSuccessful());
          } else {
            emit(EditTodoError(errorMessage: "Failed to edit the todo"));
          }
        });
      });
    }
  }
}

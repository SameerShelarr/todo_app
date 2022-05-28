import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());

  final Repository repository;
  final TodosCubit todosCubit;

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(errorMessage: "The todo text cant be empty"));
      return;
    }
    emit(AddingTodo());
    Future.delayed(const Duration(seconds: 3), () {
      repository.addTodo(message).then((todo) {
        if (todo == null) {
          emit(AddTodoError(errorMessage: "Network error"));
        } else{
          todosCubit.addTodo(todo);
          emit(TodoAdded());
        }
      });
    });
  }
}

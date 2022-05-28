part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}
class AddingTodo extends AddTodoState{}
class TodoAdded extends AddTodoState{}
class AddTodoError extends AddTodoState{
  AddTodoError({required this.errorMessage});

  final String errorMessage;
}

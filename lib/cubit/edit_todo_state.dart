part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}
class EditTodoError extends EditTodoState {
  final String errorMessage;

  EditTodoError({required this.errorMessage});
}
class EditTodoSuccessful extends EditTodoState {}
class EditingTodo extends EditTodoState {}

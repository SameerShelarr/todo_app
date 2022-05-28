import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/repository.dart';
import '../data/models/todo.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit({required this.repository}) : super(TodosInitial());

  final Repository repository;

  void fetchTodos() {
    Future.delayed(const Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isComplete, todo.id).then((isChanged) {
      todo.isComplete = !todo.isComplete;
      updateTodosList();
    });
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos
          .where((todoInList) => todoInList.id != todo.id)
          .toList();
      emit(TodosLoaded(todos: todoList));
    }
  }

  void updateTodosList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
  }
}

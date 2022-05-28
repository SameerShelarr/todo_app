import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';

class Repository {

  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int todoId) async {
     final patchObj = { "isCompleted" : isCompleted.toString() };
     return await networkService.patchTodo(patchObj, todoId);
  }

  Future<Todo?> addTodo(String message) async {
    final todoObj = {
      "todo": message,
      "isCompleted": "false",
    };
    final todoMap = await networkService.addTodo(todoObj);
    return todoMap == null ? null : Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(int todoId, String text) async {
    final patchObj = { "todo" : text };
    return await networkService.patchTodo(patchObj, todoId);
  }
}
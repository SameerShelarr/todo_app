import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'screens/add_todo_screen.dart';
import 'screens/edit_todo_screen.dart';
import 'screens/todos_screen.dart';

class AppRouter {
  late Repository repository;
  late TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todosCubit,
                  child: const TodosScreen(),
                ));
      case editTodoRoute:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => EditTodoCubit(
                  repository: repository, todosCubit: todosCubit
              ),
              child: EditTodoScreen(todo: todo),
            ));
      case addTodoRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddTodoCubit(
                      repository: repository, todosCubit: todosCubit
                  ),
                  child: AddTodoScreen(),
                ));
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/presentation/app_router.dart';
import 'presentation/app_router.dart';

void main() {
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: homeRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}

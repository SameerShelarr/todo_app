import 'dart:convert';
import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/todos"));
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int todoId) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$todoId"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    try {
      await delete(Uri.parse(baseUrl + "/todos/$todoId"));
      return true;
    } catch (e) {
      return false;
    }
  }
}
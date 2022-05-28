class Todo {
  String todoMessage;
  bool isComplete;
  int id;

  Todo.fromJson(Map json)
      : todoMessage = json["todo"],
        isComplete = json["isCompleted"] == "true",
        id = json["id"] as int;
}

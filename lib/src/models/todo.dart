import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String todo;
  String todoId;
  bool finished;

  Todo(
    this.todo,
    this.todoId,
    this.finished,
  ) {}

  Todo.fromDocumentSnapshot(DocumentSnapshot doc) {
    this.todo = doc.data()['what'];
    this.todoId = doc.id;
    this.finished = doc.data()['hecho'];
  }
}

List<Todo> toTodoList(QuerySnapshot query) {
  return query.docs.map((doc) => Todo.fromDocumentSnapshot(doc)).toList();
}

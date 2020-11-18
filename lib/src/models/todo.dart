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

  Todo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.todo = documentSnapshot.data()['what'];
    this.todoId = documentSnapshot.id;
    this.finished = documentSnapshot.data()['hecho'];
  }
}

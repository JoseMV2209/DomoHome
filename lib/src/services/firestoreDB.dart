import 'package:DomoHome/src/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreDB();

  Stream<List<Todo>> getCollection(String nombreColl) {
    return _firestore
        .collection(nombreColl)
        .snapshots()
        .map(toTodoList);
  }

  Future<void> addTodo(String todo) async {
    try {
      await _firestore.collection('tareas').add({
        'hecho': false,
        'what': todo,
      });
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> updateTodo(Todo todo, String campo, dynamic data) async {
    try {
      await _firestore
          .collection('tareas')
          .doc(todo.todoId)
          .update({campo: data});
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}

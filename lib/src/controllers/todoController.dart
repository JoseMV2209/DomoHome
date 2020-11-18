import 'package:DomoHome/src/models/todo.dart';
import 'package:DomoHome/src/services/firestoreDB.dart';
import 'package:get/state_manager.dart';

class TodoController extends GetxController {
  Rx<List<Todo>> todoList = Rx<List<Todo>>();

  List<Todo> get todos => todoList.value;

  @override
  void onInit() {
    todoList.bindStream(FirestoreDB().getCollection('tareas'));
  }
}

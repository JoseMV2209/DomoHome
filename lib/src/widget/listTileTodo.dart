import 'package:flutter/material.dart';

import 'package:DomoHome/src/models/todo.dart';
import 'package:DomoHome/src/services/firestoreDB.dart';
import 'package:DomoHome/src/functions/modificarTextTileList.dart';

class ListTileTodo extends StatelessWidget {
  Todo todo;

  ListTileTodo(this.todo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Text(todo.todo ?? ""),
          IconButton(
            icon: Icon(Icons.mode_outlined),
            onPressed: () {
              return modificarTextTileList(context, todo);
            },
          ),
        ],
      ),
      subtitle: Text(todo.todoId),
      trailing: IconButton(
        icon: Icon(
          Icons.done,
          color: todo.finished ?? false ? Colors.greenAccent : Colors.redAccent,
        ),
        onPressed: () {
          FirestoreDB().updateTodo(
            todo,
            'hecho',
            todo.finished ? false : true,
          );
        },
      ),
    );
  }
}

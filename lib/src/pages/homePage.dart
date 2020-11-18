import 'package:DomoHome/src/widget/appbarCustom.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:DomoHome/src/controllers/todoController.dart';
import 'package:DomoHome/src/models/todo.dart';
import 'package:DomoHome/src/services/firestoreDB.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initFirebase;

  @override
  Widget build(BuildContext context) {
    this._initFirebase = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBarCustom(
        context: context,
        title: 'Domotica',
      ),
      body: Center(
        child: FutureBuilder(
          future: _initFirebase,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return todosView(context);
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Widget todosView(BuildContext context) {
  return GetX<TodoController>(
    init: Get.put<TodoController>(TodoController()),
    builder: (TodoController todoController) {
      if (todoController != null && todoController.todos != null) {
        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Text(todoController.todos[index].todo ?? ""),
                  IconButton(
                    icon: Icon(Icons.mode_outlined),
                    onPressed: () {
                      _modificarText(context, todoController.todos[index]);
                    },
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.done,
                  color: todoController.todos[index].finished ?? false
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
                onPressed: () {
                  FirestoreDB().updateTodo(todoController.todos[index], 'hecho',
                      todoController.todos[index].finished ? false : true);
                },
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Future _modificarText(context, Todo todo) {
  final TextEditingController _todoCtrl =
      TextEditingController(text: todo.todo);

  final TextEditingController _verticalPadding =
      TextEditingController(text: '144');

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Modificar campo: '),
      insetPadding: EdgeInsets.symmetric(
        vertical: double.parse(_verticalPadding.text),
        horizontal: 30,
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.blue,
          child: Text(
            'Aceptar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            if (_todoCtrl.text != "") {
              FirestoreDB().updateTodo(todo, 'what', _todoCtrl.text);
              _todoCtrl.clear();
              Navigator.of(context).pop();
            }
          },
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Column(
        children: <Widget>[
          TextField(
            controller: _todoCtrl,
            decoration: InputDecoration(
              suffix: IconButton(
                  icon: Icon(Icons.backspace_outlined),
                  onPressed: () {
                    _todoCtrl.clear();
                  }),
            ),
            onSubmitted: (value) {
              if (_todoCtrl.text != "") {
                FirestoreDB().updateTodo(todo, 'what', _todoCtrl.text);
                _todoCtrl.clear();
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

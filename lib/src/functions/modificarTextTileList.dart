
import 'package:flutter/material.dart';

import 'package:DomoHome/src/models/todo.dart';
import 'package:DomoHome/src/services/firestoreDB.dart';

Future modificarTextTileList(context, Todo todo) {
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
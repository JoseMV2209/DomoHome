import 'package:flutter/material.dart';

import 'package:DomoHome/src/services/firestoreDB.dart';

import 'package:DomoHome/src/models/todo.dart';

import 'package:DomoHome/src/widget/appbarCustom.dart';
import 'package:DomoHome/src/widget/listTileTodo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreDB db = new FirestoreDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context: context,
        title: 'Domotica',
      ),
      body: Center(
        child: StreamBuilder(
          stream: db.getCollection('tareas'),
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error' + snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Todo> todos = snapshot.data;

            return ListView.separated(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTileTodo(todos[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 4,
                  indent: 75,
                  endIndent: 15,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

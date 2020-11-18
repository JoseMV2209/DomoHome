import 'package:flutter/material.dart';

Widget appBarCustom({BuildContext context, String title}) {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

  return  AppBar(
    title: Center(
      child: Text(title),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add_alert),
        tooltip: 'Show Snackbar',
        onPressed: () {
          scaffoldKey.currentState.showSnackBar(snackBar);
        },
      ),
    ],
  );
}

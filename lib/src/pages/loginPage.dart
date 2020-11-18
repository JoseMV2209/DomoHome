import 'package:DomoHome/src/widget/appbarCustom.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        title: 'Login',
        context: context,
      ),
      body: Text('Contenido de login'),
    );
  }
}

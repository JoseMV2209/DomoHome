import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future<FirebaseApp> initFirebase = Firebase.initializeApp();

  @override
  void initState() {
    // TODO: implement initState

    initFirebase.whenComplete(() {
      Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
        () => Navigator.of(context)
            .pushReplacementNamed('home', arguments: initFirebase),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: .4,
              child: FlutterLogo(
                size: 80,
              ),
            ),
            Text('Welcome'),
            SizedBox(
              height: 200,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

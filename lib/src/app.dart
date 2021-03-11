import 'package:dd/src/screens/logIn.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(accentColor: Colors.orange, primaryColor: Colors.blue),
      home: loginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:eloquent_notes/screens/welcome.dart';
import 'package:eloquent_notes/utils/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eloquent Notes',
      theme: themeData(),
      home: WelcomeScreen(),
    );
  }
}


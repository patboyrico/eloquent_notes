
import 'package:eloquent_notes/screens/add_notes.dart';
import 'package:flutter/material.dart';


class CustomFloating extends StatefulWidget {
  @override
  _CustomFloatingState createState() => _CustomFloatingState();
}

class _CustomFloatingState extends State<CustomFloating> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    onPressed: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNotesScreen())),
    child: Icon(Icons.add),
    backgroundColor: Color(0xFF417BFB),
  );
  }
}
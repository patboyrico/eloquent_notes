import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(children: <Widget>[
        Expanded(
            flex: 4,
            child: Container(
              color: Colors.black,
            )),
        Expanded(
            flex: 6,
            child: Container(
              color: Color(0xffdddcde),
            ))
      ]),
    );
  }
}
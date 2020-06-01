import 'package:eloquent_notes/screens/dashboard.dart';
import 'package:eloquent_notes/utils/size_config.dart';
import 'package:eloquent_notes/utils/theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              body: Container(
                  child: Column(
                children: <Widget>[
                  Expanded(flex: 8, child: TopContainer()),
                  Expanded(flex: 3, child: BottomContainer())
                ],
              )),
            );
          },
        );
      },
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
              // left: -60,
              // top: -200,
              child: Image.asset('assets/images/notes.jpg',
                  fit: BoxFit.cover, height: 1800)),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xff000000).withOpacity(.6),
                  Color(0xff2b5366).withOpacity(.53),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 3.6,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Eloquent Notes',
                        textAlign: TextAlign.center,
                        style: headingFontStyle(
                            fontsize: SizeConfig.textMultiplier * 5.5, color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 19,
                      ),
                      Text(
                        'Take Beautiful Notes And Keep Em Saved Like A Pro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30.0),
          child: RaisedButton(
            // elevation: 5.0,
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen())),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            padding: EdgeInsets.all(15.0),
            color: Colors.grey,
            child: Text(
              'CONTINUE',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

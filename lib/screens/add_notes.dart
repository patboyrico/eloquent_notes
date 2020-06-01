import 'package:eloquent_notes/helpers/db_helper.dart';
import 'package:eloquent_notes/models/notes.dart';
import 'package:eloquent_notes/utils/size_config.dart';
import 'package:eloquent_notes/utils/theme.dart';
import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/notes_2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff000000).withOpacity(.6),
                Color(0xff2b5366).withOpacity(.53),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
          MainScreen()
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEdited = false;
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add Note',
                      style: headingFontStyle(
                          fontsize: SizeConfig.textMultiplier * 3,
                          color: Colors.white),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Container()
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                // color: colors[color],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        // controller: titleController,
                        maxLength: 255,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          // updateTitle();
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        // controller: titleController,
                        maxLength: 255,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          // updateTitle();
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: 'Category',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 20,
                          maxLength: 255,
                          // controller: descriptionController,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            // updateDescription();
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

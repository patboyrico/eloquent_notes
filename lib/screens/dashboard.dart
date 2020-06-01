import 'package:eloquent_notes/helpers/db_helper.dart';
import 'package:eloquent_notes/models/notes.dart';
import 'package:eloquent_notes/screens/notes.dart';
import 'package:eloquent_notes/utils/floating.dart';
import 'package:eloquent_notes/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  List<String> categoryList;

  int _selectedCategoryIndex = 0;
  // TabController _tabController;
  final DateFormat _dateFormatter = DateFormat('dd MMM');
  final DateFormat _timeFormatter = DateFormat('h:mm');

  @override
  void initState() {
    super.initState();
    getNotes();
    getCategories();
    // _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  void getNotes() {
    final Future<Database> dbFuture = databaseHelper.initialiseDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        this.noteList = noteList;
      });
    });
  }

  void getCategories() {
    final Future<Database> dbFuture = databaseHelper.initialiseDatabase();
    dbFuture.then((database) {
      Future<List<String>> categoryListFuture = databaseHelper.getCategories();
      categoryListFuture.then((categoryList) {
        this.categoryList = categoryList;
      });
    });
  }

  Widget _buildCategoryCard(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 200.0,
        width: 215.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Colors.black
              : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xFFAFB4C6),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(20.0),
            //   child: Text(
            //     count.toString(),
            //     style: TextStyle(
            //       color: _selectedCategoryIndex == index
            //           ? Colors.white
            //           : Colors.black,
            //       fontSize: 35.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      getNotes();
    }

    if (categoryList == null) {
      categoryList = List<String>();
      getCategories();
    }

    return Scaffold(
      floatingActionButton: CustomFloating(),
      body: Stack(children: <Widget>[
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
        noteList.length == 0
            ? Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'You have no notes yet. Click on the add button to add a new note!',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0
                        )),
                  ),
                ),
              )
            : Container(
                child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Overview',
                              style: headingFontStyle(
                                  fontsize: 26.0, color: Colors.white),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotesScreen()))),
                                IconButton(
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                    ),
                                    onPressed: null),
                              ],
                            )
                          ]),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: this.categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return SizedBox(width: 20.0);
                          }
                          return _buildCategoryCard(
                            index - 1,
                            this.categoryList[index],
                            // categories.values.toList()[index - 1],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Most Recent',
                              style: headingFontStyle(
                                  fontsize: 18.0, color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    
                  ],
                ),
              ))
      ]),
    );
  }
}

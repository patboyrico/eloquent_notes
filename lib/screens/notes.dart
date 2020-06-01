
import 'package:eloquent_notes/helpers/db_helper.dart';
import 'package:eloquent_notes/models/notes.dart';
import 'package:eloquent_notes/utils/size_config.dart';
import 'package:eloquent_notes/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[ Container(
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
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter))), MainScreen()],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(initialPage: 0);

  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;

  @override
  void initState() {
    super.initState();
  }

  void getNotes() {
    final Future<Database> dbFuture = databaseHelper.initialiseDatabase();
    dbFuture.then((database) {
        Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
        noteListFuture.then((noteList){
              this.noteList = noteList;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
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
                    'Notes',
                    style: headingFontStyle(
                        fontsize: SizeConfig.textMultiplier * 3,
                        color: Colors.white),
                  ),
                  Row(children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.list),
                      onPressed: () {
                        setState(() {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut);
                        });
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.apps),
                      onPressed: () {
                        setState(() {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut);
                        });
                      },
                    )
                  ])
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: pageController,
                onPageChanged: (pageNum) {},
                children: <Widget>[NotesPage(notes: this.noteList), GridViewScreen(notes: this.noteList)],
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  final List<Note> notes;

  NotesPage({this.notes});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final DateFormat _dateFormatter = DateFormat('dd MMM');
  final DateFormat _timeFormatter = DateFormat('h:mm');


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.notes.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return GestureDetector(
                  onTap: () => print('object'),
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.notes[index].title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                _timeFormatter.format(widget.notes[index].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            widget.notes[index].content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                _dateFormatter.format(widget.notes[index].date),
                                style: TextStyle(
                                  color: Color(0xFFAFB4C6),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF417BFB),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}


class GridViewScreen extends StatefulWidget {

  final List<Note> notes;

  GridViewScreen({this.notes});

  @override
  _GridViewScreenState createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          itemCount: widget.notes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: GridTile(
                footer: Text(widget.notes[index].title),
                child: Text(widget.notes[index].content), //just for testing, will fill with image later
              ),
            );
          },
        );
      },
    );
  }
}

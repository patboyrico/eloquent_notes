import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      searchBarStyle: SearchBarStyle(
        padding: EdgeInsets.all(1.0),
        backgroundColor: Colors.white
      ),
      cancellationWidget: Text('Cancel', style: TextStyle(color: Colors.white)),
      iconActiveColor: Colors.black,
      textStyle: TextStyle(color: Colors.black),
      onSearch: (String text) {},
      onItemFound: (item, int index) {},
    );
  }
}

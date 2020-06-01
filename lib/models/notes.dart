class Note {
  int _id;
  String _title;
  String _category;
  String _content;
  DateTime _date;

  Note(this._id, this._title,this._category, this._date, 
    [this._content]);

  int get id => _id;
  String get title => _title;
  String get category => _category;
  String get content => _content;
  DateTime get date => _date;

  set title(String newTitle){
    if (newTitle.length <= 255) {
      this._title = newTitle; 
    }
  }

  set category(String newCategory){
    if (newCategory.length <= 255) {
      this._category = newCategory; 
    }
  }

  set content(String newContent){
    if (newContent.length <= 255) {
      this._content = newContent; 
    }
  }


  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if (id != null) {
       map['id'] = _id;
    }
    map['title'] = this._title;
    map['content'] = this._content;
    map['category'] = this._category;
    map['date'] = this._date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._content = map['content'];
    this._category = map['category'];
    this._date = map['date'];
  }


}

 


// final Map<String, int> categories = {
//   'Notes': 112,
//   'Work': 58,
//   'Home': 23,
//   'Complete': 31,
// };

